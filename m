From: "Li Frank" <Frank.Li@freescale.com>
Subject: RE: why not TortoiseGit
Date: Sun, 2 Nov 2008 22:14:10 +0800
Message-ID: <7FD1F85C96D70C4A89DA1DF7667EAE961E728C@zch01exm23.fsl.freescale.net>
References: <7FD1F85C96D70C4A89DA1DF7667EAE96125890@zch01exm23.fsl.freescale.net> <20081031121913.GE18221@sys-0.hiltweb.site> <490AFBA5.5090700@op5.se> <d411cc4a0810310857y5b4f8c46ue33e1f6a9e2c13d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Ian Hilt" <ian.hilt@gmx.com>, <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>, "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Nov 02 15:15:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwdjw-0003pt-9y
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 15:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbYKBOO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 09:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753447AbYKBOO0
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 09:14:26 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:57474 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbYKBOO0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 09:14:26 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id mA2EEGe8011982
	for <git@vger.kernel.org>; Sun, 2 Nov 2008 07:14:17 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net [10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mA2EEFl7022523
	for <git@vger.kernel.org>; Sun, 2 Nov 2008 08:14:16 -0600 (CST)
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <d411cc4a0810310857y5b4f8c46ue33e1f6a9e2c13d1@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: why not TortoiseGit
Thread-Index: Ack7cX8kg2YMosKmTp693FI7V4yvywBgc1Ig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99845>

I read some code of TortoiseSVN and TortoiseHg Code. 
At beginning, TortoiseGit can git command to get information like Qgit.
After linkable library ready, replace "git command". 

I think TortoiseGit can start base on below way.
 
1.  Base on TortoiseHg, It is python Script.  Replace below hg operator
with Git. 
2.  Base on TortoiseSVN, It is developed with C++. Need VS2008.
ToritoiseSVN provide some built in diff and merge tools. 
3.  Base on Qgit, which provide some basic UI, such comment dialogbox,
history view and file annotate. 


Best regards
Frank Li

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
Behalf Of Scott Chacon
Sent: Friday, October 31, 2008 11:58 PM
To: Andreas Ericsson
Cc: Ian Hilt; Li Frank-B20596; git@vger.kernel.org
Subject: Re: why not TortoiseGit

I'm trying to get this restarted - dscho and I talked about this at the
GitTogether, and I met some people (from the OpenAFS project that also
happened to be there, oddly) who were interested in working on this with
me.  I think the lack of a linkable library has greatly hindered the
development of projects like this, so that will likely be part of the
development process as well.

Scott

On Fri, Oct 31, 2008 at 5:35 AM, Andreas Ericsson <ae@op5.se> wrote:
> Ian Hilt wrote:
>>
>> On Fri, Oct 31, 2008 at 09:44:45AM +0800, Li Frank-B20596 wrote:
>>>
>>> There are TortoiseCVS, TortoiseSVN, TortoiseBzr, TortoiseHg Why not 
>>> ToroiseGit
>>
>> This is what Johannes Schindelin had to say,
>>
>>        <http://code.google.com/p/msysgit/wiki/GitCheetah>
>
> Noone's written TortoiseGit yet. I have no idea why, and I have no 
> reason to write it myself. If GitCheetah isn't working well, I'm sure 
> patches are welcome.
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
> --
> To unsubscribe from this list: send the line "unsubscribe git" in the 
> body of a message to majordomo@vger.kernel.org More majordomo info at

> http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe git" in the
body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
