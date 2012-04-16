From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 23:51:33 +0300
Message-ID: <CAMP44s23_Qx3R9TX4frM-JYNv7XT3eVbcZ_D45nEdh0rq-O8kA@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
	<CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
	<CAMP44s0Q2A_oKJx27ct9W__KVQkQxzst3H7gq6sZDhrCLDQaag@mail.gmail.com>
	<20120416204641.GH12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:51:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsti-0001QA-GG
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab2DPUvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 16:51:35 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38260 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab2DPUve convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 16:51:34 -0400
Received: by eaaq12 with SMTP id q12so1401467eaa.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 13:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XWGa7rlI3rXJQxBJZyXTXmmSmW34Ju16kGpKPWrI/VE=;
        b=tczWBX19q9btKxa5V0VyPRvJnsizLdP4F27vBIdBys4mNc+H0AfgwNV7Z7zF9x5LJl
         VEzxyOb+WIT+8JXUQQFGUrQmySDtQH9S+X69GarDnHHQfFWiFiPIVJoN3oLGsy4kwYDr
         9+7fqgRxKusb/nUMlQm5zhriZdYam8MWKTE8mcxpQeUZivD/YDWENX8IA2NbS+cldt0t
         BXgbx6YCju115Vx8HEhewLw9qmdIFeiAJj4ht/Iyu+2QjrS92g7Q+LbvbIAq+qK0d/I8
         gxVUlcFLpwh4XCwrc0QGjbbFd9GmTaDc7r3/ZXBK/W7HGqqT7gjdpXUJ0aw1mr/A4cJj
         srNg==
Received: by 10.14.96.6 with SMTP id q6mr1857262eef.6.1334609493641; Mon, 16
 Apr 2012 13:51:33 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 13:51:33 -0700 (PDT)
In-Reply-To: <20120416204641.GH12613@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195693>

On Mon, Apr 16, 2012 at 11:46 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>
>> Now, even if you use the bash completion library, it still does expo=
rt
>> functions without a prefix
>
> Are you sure? =C2=A0"complete" is a bash builtin and has nothing to d=
o with
> the bash completion library except that the latter uses it.

I already provided examples:
have(), quote(), dequote(), quote_readline()

--=20
=46elipe Contreras
