From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 20:06:03 +0200
Message-ID: <4A8AED8B.9080604@gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: Johan 't Hart <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 20:05:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdT3c-0006bm-8Q
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 20:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758852AbZHRSFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 14:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758720AbZHRSFE
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 14:05:04 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:39239 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063AbZHRSFC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 14:05:02 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so1806672ewy.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 11:05:03 -0700 (PDT)
Received: by 10.210.82.2 with SMTP id f2mr4907986ebb.34.1250618703904;
        Tue, 18 Aug 2009 11:05:03 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 7sm608749eyg.27.2009.08.18.11.05.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 11:05:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4A8AE7C5.7050600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126433>

Johan 't Hart said the following on 18.08.2009 19:41:
> Junio C Hamano schreef:
>> Since use of make implies use of shell, this makes me wonder if it
>> would make sense to go one step further by giving msvc users a thin
>> shell wrapper mcvc-cc that turns bog-standard cc command line into
>> whatever cl uses.
> 
> Just using the msvc toolchain for building git misses the whole
> purpose of what VC is used for. MSVC would be used because of the
> IDE, not for the compiler IMO.

Bull. MSVC produces superior code on Windows compared to MinGW, I'm 
afraid. Add the /LTGC (Link Time Code Generation), and MSVC generates 
very good cross compile-unit optimized code. (I know gcc has the option, 
but it's not as good, by far)
Coupled now with built-in static code analysis, these are only two 
reasons why *I* would want to build it directly from the command line 
without worrying that my .vcproj is out-of-sync with the main development.
You can still debug with the MSVC debugger if you'd like, and the MSVC 
IDE allows you to wrap Makefile project too, so you can *still* use the 
IDE..

--
.marius
