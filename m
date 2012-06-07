From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Introduce --current option to git-branch builtin command.
Date: Thu, 7 Jun 2012 18:23:19 +0700
Message-ID: <CACsJy8Bn2S4UT5ctMBNNB_Wf8J00nGw38F6O0P-jb3dpXEcs9w@mail.gmail.com>
References: <CAECJ0BmcxeS1q8bw4hN9jDja2g8GGzNyN_v7jC3ehOW70x6CRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?S2VudGEgTXVyYXRhICjmnZHnlLAg6LOi5aSqKQ==?= 
	<mrkn@cookpad.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 13:24:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scap3-0001NK-EB
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 13:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760741Ab2FGLYD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 07:24:03 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35199 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792Ab2FGLXx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 07:23:53 -0400
Received: by wibhn6 with SMTP id hn6so126168wib.1
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pAE77YwW43gRXlq/WPwchXhjrignbKYyoVCJT81nXZI=;
        b=WCnieKKrRQg5yZxbPhjpg70eRnXNb0nSRPKFcHWqM04VCQ5OXVgceWQMY/nh60AH4J
         8jsGFnLT6ZuEYQcqA2i4V2jeZGOP5CVjCoybEEgmZagyVO/Zvd5tEd93NgBT2PpaEGP+
         UYr0k1G3kQMveOnzE6VxZ8bn8svEufFxESuN3k7SvmDgmVQz36louRIqIc5vcSTnl+t9
         PMaSkjqSIx4ZQu5qGPnz6RKPQOBX+1USl6vRgsdg7A+PcO4HLta8rHOeKadr7lNLKsCR
         1muBL3Yak9RFr/oRKUl7WoUmUVQjP28gnxV+UR37wOJuidxNhxJ/LUriD7TFlSm5FEct
         eHEg==
Received: by 10.216.195.19 with SMTP id o19mr640273wen.207.1339068232261; Thu,
 07 Jun 2012 04:23:52 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 7 Jun 2012 04:23:19 -0700 (PDT)
In-Reply-To: <CAECJ0BmcxeS1q8bw4hN9jDja2g8GGzNyN_v7jC3ehOW70x6CRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199392>

On Thu, Jun 7, 2012 at 2:23 PM, Kenta Murata (=E6=9D=91=E7=94=B0 =E8=B3=
=A2=E5=A4=AA) <mrkn@cookpad.com> wrote:
> Introducing --current option to git-branch builtin command.
> This option allows us to simply show the current branch name.

or just add an alias that does "git symbolic-ref HEAD" (append "|sed
s,^refs/heads,," if you don't like full ref)
--=20
Duy
