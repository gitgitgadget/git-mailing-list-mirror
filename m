From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Tue, 7 Jan 2014 20:44:51 +0100
Message-ID: <CALas-ijD977divDQtY0ZhDAQiA60aGLr0KzN+QvoL=zTb1z=6A@mail.gmail.com>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com>
 <1388890249-3577-2-git-send-email-ceztko@gmail.com> <20140105203349.GB3737@book.hvoigt.net>
 <CALas-ijjzyRVuc0NaAS5QS98pX2198mv4HoHDacgYFYNLXbXFw@mail.gmail.com>
 <20140106140627.GA27265@t2784.greatnet.de> <CALas-ihHD_eJOXLUrhCVZjidQDmrCN=QpdfMKoN1i9A7FAo3RQ@mail.gmail.com>
 <xmqq38kzei3d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:45:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0caX-0006mF-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbaAGTpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:45:19 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:53667 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbaAGTpM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:45:12 -0500
Received: by mail-oa0-f43.google.com with SMTP id m1so710205oag.30
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 11:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0Ty3duKaH3sZ13cDwWNGwkkDELpLyzsmK/fAdHzI6hc=;
        b=Rqh5aoFtFr+fGJSHbS86i+rvCmLojOgPXA8yGXmPD78Mi8VhvMNbzSQyYvExqcfFa8
         3RawY0opOJQQC9PcZz+bEzAQulj2FVS/9UtFI0lr5HNkXo0LRRpr5WkpD5yh1mgYXqWL
         643QoiQWb8MaY/oGNURcZfZI/CaOp1HDuFwyAWq26Lo1/27zQ99gebpwrIF80e7U9Ji+
         25tsVtqWLPuSop1nX8SLbZmGN4huGpyxLqafv+Rg8CZOpgNqYOAJfS0qI9PA98e1zvZ7
         8A1GTCU5ZYq0Rv4Xf1j46PiYoa+B6Af42ZSspnHqkYr3sbCxf0NqL773cORLJ2vv67LG
         0i3w==
X-Received: by 10.182.48.130 with SMTP id l2mr7619015obn.44.1389123912034;
 Tue, 07 Jan 2014 11:45:12 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 7 Jan 2014 11:44:51 -0800 (PST)
In-Reply-To: <xmqq38kzei3d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240138>

2014/1/7 Junio C Hamano <gitster@pobox.com>:
> Francesco Pretto <ceztko@gmail.com> writes:
>> The developer does it voluntarily, at his responsibility, because he
>> may decide to partecipate more actively to the development of the
>> submodule and still want to use a simple "git submodule update" to
>> updates his submodules, overriding its configuration as it can be done
>> for other properties like, for example, "branch".
>
> It is still unclear to me why we need attached/detached mode for
> that.  The developer may want to do an exploratory development,
> whose result is unknown to deserve to be committed on the specified
> branch at the beginning, and choose to build on a detached HEAD,
> which is a perfectly normal thing to do.  But the standard way to do
> so, whether the developer is working in the top-level superproject
> or in a submodule, would be to just do:
>
>         cd $there && git checkout HEAD^0
>
> or use whatever commit the state to be detached is at instead of
> "HEAD" in the above example, no?
>

Because of the overlapping change with the the other patch proposed by
Trevor, and to not generate confusion, I will stop for now pursuing
for an "attach|detach" command/switch specific for submodules, waiting
for Trevors's patch possible acceptance. After that I will see it
still makes sense or not.
