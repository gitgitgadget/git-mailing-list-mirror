From: David Krmpotic <david.krmpotic@gmail.com>
Subject: Re: auto merge bug
Date: Tue, 5 Mar 2013 23:13:12 +0100
Message-ID: <CAOFaZ+4oUD7eMvFmtPdca4AYooxW-PCOiPBUb0jjVw4LPBN8+Q@mail.gmail.com>
References: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com>
 <20130305090326.GC13552@sigill.intra.peff.net> <7vtxopvoky.fsf@alter.siamese.dyndns.org>
 <20130305175904.GC9379@sigill.intra.peff.net> <7va9qhu1jk.fsf@alter.siamese.dyndns.org>
 <194F685F-9460-42C6-B5A5-59475F53D038@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 23:14:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD07U-0007CE-4I
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 23:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554Ab3CEWNe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 17:13:34 -0500
Received: from mail-we0-f182.google.com ([74.125.82.182]:37846 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab3CEWNe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 17:13:34 -0500
Received: by mail-we0-f182.google.com with SMTP id t57so7169366wey.13
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 14:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=2G5WiS4soTUUim1ThzDi7Pa2aKNPqdlF2RYRzNGG6Dg=;
        b=sXElryUctm4aWCJUVcs3EreRxQXaEaevDFJys7NnekOY8tNbPRLLdGeB0HRRdNc8Dh
         P2/iOlN/UPhR43HXLh9tip/ffWvBxkoYUmjeZ/0PadPvo6zKcIJCDPpBRO/3QcUfhikh
         pPSMRKmpipBuWp1yTRc01U/Ak2HGYB+c87WxrTEVTxzkF0tigqIn9PAYIGb6Z5ZOEVsF
         heyk5qeyoqwi/DYa41kMuBStJTmTx50Md1IB4oYXEt9FxiLA4S+da0CrEgoIpSM5iZG6
         Wlpc5QT/oZQ/PmT3u4o/YT4/LZuppkJ/4EcRAm2bXYhFnjE/osmVqC6UKSYJNns9f4Im
         Cghg==
X-Received: by 10.194.58.202 with SMTP id t10mr42940399wjq.4.1362521612945;
 Tue, 05 Mar 2013 14:13:32 -0800 (PST)
Received: by 10.194.143.70 with HTTP; Tue, 5 Mar 2013 14:13:12 -0800 (PST)
In-Reply-To: <194F685F-9460-42C6-B5A5-59475F53D038@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217488>

Hi guys! Thank you for responses.. I haven't suspected that repos
created via GitHub windows app would have union set by default :( have
to ask them about it.. it seems wrong to me=85 Here are the defaults fo=
r
a windows repo created with GitHub for windows app:

logo (master)$ cat .gitattributes
# Auto detect text files and perform LF normalization
* text=3Dauto

# Custom for Visual Studio
*.cs     diff=3Dcsharp
*.sln    merge=3Dunion
*.csproj merge=3Dunion
*.vbproj merge=3Dunion
*.fsproj merge=3Dunion
*.dbproj merge=3Dunion

# Standard to msysgit
*.doc	 diff=3Dastextplain
*.DOC	 diff=3Dastextplain
*.docx diff=3Dastextplain
*.DOCX diff=3Dastextplain
*.dot  diff=3Dastextplain
*.DOT  diff=3Dastextplain
*.pdf  diff=3Dastextplain
*.PDF	 diff=3Dastextplain
*.rtf	 diff=3Dastextplain
*.RTF	 diff=3Dastextplain

While investigating my problem I have read about the special union
merge mode, but didn't check if maybe my repo was in that mode..
really didn't expect it.

THANK YOU again=85 now I'll write to the github guys..


David
