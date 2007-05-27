From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 03:30:53 -0300
Message-ID: <4659259D.4000803@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <Pine.LNX.4.64.0705262318190.4648@racer.site> <4658BA64.2050904@xs4all.nl> <f3agkk$bhn$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 08:33:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsCJL-0006Lb-3w
	for gcvg-git@gmane.org; Sun, 27 May 2007 08:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbXE0Gc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 02:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXE0Gc5
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 02:32:57 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:4354 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXE0Gc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 02:32:57 -0400
Received: from [192.168.1.100] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4R6WpvH088973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 May 2007 08:32:53 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <f3agkk$bhn$1@sea.gmane.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48520>

Jakub Narebski escreveu:

>> Instead, we have a Makefile that relies on an esoteric combination of
>> perl and shell scripting inside Makefiles.
> 
> The idea is to be able to get reasonable defaults (depending on system of

This saves the user on Linux or similar platform one ./configure call. For
the rest it means editing makefiles. I'm not sure if that is an improvement
over the standard 

  configure ; make ; make install

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
