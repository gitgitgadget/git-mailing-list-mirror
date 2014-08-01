From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: Git Help needed
Date: Fri, 1 Aug 2014 12:58:19 -0700
Message-ID: <CAL=YDWmOSQaJ9NrgK_kOOv5_3hXhcQL65BhJeG=UtY1+RExOCA@mail.gmail.com>
References: <898fcfcd0c4f41da805abdd41622058f@DM2PR08MB477.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: RaviKiranGoud_Palpanoori@vfc.com
X-From: git-owner@vger.kernel.org Fri Aug 01 21:58:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDIy9-00054x-4d
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 21:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbaHAT6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 15:58:21 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:50880 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaHAT6U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 15:58:20 -0400
Received: by mail-vc0-f182.google.com with SMTP id hy4so7644370vcb.27
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0PHmw8tz111KtgiJNF6JEoNYG7HXZWFcmjn0Z7mY+cA=;
        b=ldWabHdgPt7Ur8KQZnR1EyGUqosIc3RbLizltgpE6/1po2MB8YWbVzXWVG2b7Zra4s
         fyJHAUY68SpSc4Tzvom8wsUhYvI2ptshcRELe2vuBW8Bjg69NFSevwCia0dSmCHQ5/34
         Cpx4nCoeQJTKn1+Z5g00fGQB49STiHkNjYWBCuVbk/ZTtogL5IFELtOcFCIJr5aGXqI2
         yyLDh9IJVBxUpg/oR7mxYzvJ8e13aLVqS7MKoMDL/HhLzr9kLNXl+5KWyDqjBKOqBtM5
         DCEAb65kI4F3xd7bZaA8UFJs6ks1esQb6iuHjuZpRJOR22rdl2TgKJa0L0Bi7ehOsFIl
         u2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0PHmw8tz111KtgiJNF6JEoNYG7HXZWFcmjn0Z7mY+cA=;
        b=ISqhaT+NL3YtmZzcJg4dkBMco4p4EYkMnAu7VewRH+cdx7z6EVaYQ1kFZeJLt0ZQme
         h9WUIB1ZZIEQ3KI5WCkhLX9FiBCck6E+PmGWuZv2IT06txoKVbAU0WVD1Xpm/moyRaXE
         hhiRttKHK1y8dCE7G0WdWWdvDQ8XOKHWB9AFSxh3G2oIEwmRR6Ps21dUpBURhOnfyIgQ
         hByjg0cspjlHXCAEHddOhA+lHtMi++BgXekBsmF4txSFz0pH0WxhRy3xiNCmp8o+tb/I
         SyaMSJHNPqXEsRZBhde8pzu6i87LhaBo9qIwmWNGEUp6RF8zRzE74divsvULP3vv3/7V
         1QPg==
X-Gm-Message-State: ALoCoQkR+1UrGIliU6zAHSN07fUNSehQ5uABTt2UVgFH78HTIK5OE1aJuclPIkQykY8Qz9Ne9Szt
X-Received: by 10.52.9.35 with SMTP id w3mr8030317vda.12.1406923099261; Fri,
 01 Aug 2014 12:58:19 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Fri, 1 Aug 2014 12:58:19 -0700 (PDT)
In-Reply-To: <898fcfcd0c4f41da805abdd41622058f@DM2PR08MB477.namprd08.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254656>

This looks more like a packaging/build issue than a git issue.

It looks like whomever built your version of git built it against a
specific version of the OpenSSL library.
You should probably contact the folks that built your binary and ask
them to update and build against the version that the new version of
aix ships with.

Alternatively if you build git yourself on that host you should end up
with a binary that links with the version of the library that you
currently have.



On Fri, Aug 1, 2014 at 12:30 PM,  <RaviKiranGoud_Palpanoori@vfc.com> wrote:
> Hi,
> I am writing below couple of questions. If it is not the right place to ask please ignore and suggest me what to do to get the help on these questions.
>
> 1) What version of SSL is supported by GIT 1.8.3 or GIT 1.9.0
>
> 2) I have installed git 1.8.3 in AIX server 6.1 TL8 SP2. It worked fine and able to extract code from git repository directly as well as from ant. Everything went well.
> Recently Aix OS upgraded to 6100-09-01-1341. After OS upgrade my git commands are not working. Basic help and version works fine as expected. When I try to pull the code from git repository it give SSL library compatibility issue.
>
> The error is
> OpenSSL version mismatch. Built agains 1000105f, you have 100000bf
> fatal: Could not read from remote repository
>
> In order to get rid of this, I upgraded git to 1.9.0 GIT. But still it didn't work. The issue is still coming.
>
> git help, version works.
> When I tried directly pulling code using git pull command - didn't work.
> When I try to pull the code through the ant - didn't work
>
> The ant version is 1.8.0RC1
>
> AIX admin worked on this and provided below comments
>
> Comments form AIX system admin  (Pasted as it is)
> Even after installing 1.9.0 version of GIT the library files are not compatible with the latest version of SSL (1.0.5.1).
> SSL works fine as a root user and other users. This compatibility issue only a raises when the LIBPATH for GIT is set and the SSL picks up its LIBPATH from the same location as GIT and this causes the incompatibility.
> Can you find out from the GIT/ANT support team on what version of SSL GIT supports exactly. - The is specifically with the GIT/SSL as the user "xyzabc" . The SSL otherwise works perfectly fine.
> You will have to re-compile the ANT libraries to use the latest library files.
>
> Thanks in advance.
>
> Regards,
> Ravi.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
