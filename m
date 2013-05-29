From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git ignore regression in 1.8.3
Date: Wed, 29 May 2013 20:31:04 +0700
Message-ID: <CACsJy8BT_3aUAO+eMT6F3SWwLOWeFwJ2rxxru-+NtBRD3RTSFw@mail.gmail.com>
References: <CAPqtr1KjmqRZZuVwput6=rKJrivb7siYePqT5QEOLJApg+phEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?Q?Nicolas_Despr=C3=A8s?= <nicolas.despres@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgTc-0007g6-60
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935121Ab3E2Nbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 09:31:35 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:53990 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3E2Nbf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 09:31:35 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so3039044obq.7
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hH3+J9kjQmqz3MCKMq3WEfff6PzurT41aK9HoAGXgg4=;
        b=dKLT0TqqGk6AK9DQ1hqQwM/RcMDawnTpPnpEjL+HYmnFf5GsAn3Zk8+67nE77aMH1I
         brDUltmDwOC6ImJviEQl3C0FP9WgICLs0HqOY2I6xYtOhQTeTIMgXPjKUU5O+fR+jp1v
         WyPCHD7M34V2p1zuQga5u9+xY9You4A2AoAoRf5u8YCIpVYjNkLfYTw+jSF5rk9IVCSr
         Jm0h7+v3kjEXGrR978fotnFfHTS4RJpE6k6DMvQ9oj4RZUTcc0ccoCt1ep+R8/4rsZcU
         mlp//fJg31DWqTF6SPmpFo78gaxtNHaBoyLWJr2N66yMv5yXaQJbU0Dar5f0u3E8/jUq
         9BmQ==
X-Received: by 10.182.106.130 with SMTP id gu2mr1647990obb.0.1369834294388;
 Wed, 29 May 2013 06:31:34 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Wed, 29 May 2013 06:31:04 -0700 (PDT)
In-Reply-To: <CAPqtr1KjmqRZZuVwput6=rKJrivb7siYePqT5QEOLJApg+phEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225817>

On Wed, May 29, 2013 at 7:31 PM, Nicolas Despr=C3=A8s
<nicolas.despres@gmail.com> wrote:
> I have noticed a regression in the behavior of ignore rules in 1.8.3.

Yeah, it looks like everybody suddenly realizes this regression soon
after the release, not before :( This has been reported three times so
far. You may want to check the discussion (and hopefully progress
soon) in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/225675/focus=3D2=
25713

We really need to add some real world use cases of gitignore in the tes=
t suite.
--
Duy
