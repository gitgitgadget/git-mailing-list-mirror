From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] gitk: Update German translation.
Date: Tue, 15 Jan 2008 13:49:15 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801151349.15863.stimming@tuhh.de>
References: <200801092224.21680.stimming@tuhh.de> <18316.40706.103240.308564@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 13:54:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JElJ0-0000M1-2F
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 13:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270AbYAOMvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 07:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757266AbYAOMvz
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 07:51:55 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:48662 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255AbYAOMvx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 07:51:53 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m0FCpnUZ031423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 15 Jan 2008 13:51:49 +0100
Received: from [192.168.2.102] (p5490137A.dip0.t-ipconnect.de [84.144.19.122])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m0FCpl4o010440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 13:51:49 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <18316.40706.103240.308564@cargo.ozlabs.ibm.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70519>

Am Dienstag, 15. Januar 2008 12:54 schrieb Paul Mackerras:
> Christian Stimming writes:
> > Now 100% complete (163 strings).
>
> I notice you didn't translate the text that is put in the key bindings
> help window.  Was that intentional?  

No, it wasn't intentional. In fact, the string (the whole text content) has 
been marked by [mc ...], but it doesn't show up in po/gitk.pot and hence not 
in po/foo.po. I don't know why this is the case...

> Would it perhaps be best to pass 
> each line of the message through [mc] separately?

Probably yes. I.e. both the key name and the explanation together should be 
one message, like so:
"
[mc "<Return>	Move to next find hit"]
[mc ...]
"

Are you up to preparing a patch? That would be nice. Thanks a lot.

Christian
