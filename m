From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 01/10] ref-filter: add option to align atoms to the left
Date: Sun, 26 Jul 2015 01:58:23 -0400
Message-ID: <CAPig+cQD3tMmOrYFb=iWEq7CptDgwarZWW3WDGh7QGKVavgWGA@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
	<1437764685-8633-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cQSy6imD_z+a9tvprJtn2-20awLJOcUQAksyv6HceVzxQ@mail.gmail.com>
	<CAOLa=ZQvMV8C6LV-+B3m74x209Fr1X7W=piaL-Eftu_PdRW64w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 07:59:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJExn-0003lq-Kd
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 07:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbbGZF6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 01:58:24 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33185 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbbGZF6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 01:58:24 -0400
Received: by ykfw194 with SMTP id w194so47880093ykf.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 22:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2YARGPBQrrzMrg0a+4uup63JsnXvjz0hPiEwl6bDqlE=;
        b=mME2m0E9pSb+R9zmguWP1dciSfyZK26LEgsAXJaUPsDy1vNt1Xj6LEP3KdE+V7a6Er
         dpkt6n+WfaQGEGJDVfgsz52Ec1pfX/7nQJr8vf5HvLyT8fwUyx5eIaWMWvjv0kcsNJZN
         rY51p/mcuWRsv2Lj3XmfDxstv9jXwBRcgYgsC0uhRvu1TGuucSYMgVBovngUT0RgZaBs
         wG+XFVhlpeKoTVOs24vtdI+0Ig9Nfe50olb6ze5UpQpjXCdAjBhodPSlL2AFm0W2Epwj
         YUm9n6FX03bo6uxEYXzACGwvVF6Ek0tbNG55xiaC0eUT0aUXbSYZkfjFHXVlphm2AeVo
         /1Aw==
X-Received: by 10.170.196.4 with SMTP id n4mr23439773yke.127.1437890303469;
 Sat, 25 Jul 2015 22:58:23 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 25 Jul 2015 22:58:23 -0700 (PDT)
In-Reply-To: <CAOLa=ZQvMV8C6LV-+B3m74x209Fr1X7W=piaL-Eftu_PdRW64w@mail.gmail.com>
X-Google-Sender-Auth: gBsuzgfUVpcGS5iBcuTzjviNdG8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274637>

On Sun, Jul 26, 2015 at 12:36 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Jul 26, 2015 at 9:38 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Also, it is helpful to reviewers if you include an interdiff at the
>> bottom of your cover letter showing the changes from one version to
>> another. You can generate an interdiff with "git diff branchname-v4
>> branchname-v5", for instance.
>
> I've been working on the same branch, and that's why I didn't really
> provide interdiff's, and I kinda worked on the same branch again,
> so I wont be giving an interdiff for the next series either, but I'll keep this
> in mind and follow it from the forthcoming patch series. Thanks

You can still provide an interdiff. It is quite likely that you can
find the commit corresponding to v4 in the reflog for that branch (see
git-reflog). Failing that, an easy way to recover the state at v4 is
to create a new branch (from the parent of your current working
branch) and apply the v4 patches which you sent to the mailing list.
If Junio queued v4 in his 'pu' branch, then you can also recover from
there. Once you've recovered the state of v4 using one of the methods
mentioned here (or some other), you can make an interdiff when sending
out v5.

Reviewers do appreciate that you provide a URL to the previous version
and take the time to explain in your cover letter what changed (and
why). Including an interdiff is one more way to ease the review
process, and is also appreciated, so it may be worthwhile to put in
the effort to recover the state of v4 so that you can include an
interdiff with v5. Doing so does require a bit of extra work for you,
but that's work you only need to do *once*, whereas if you don't do
it, then you place the burden on *each* reviewer for *each* version,
which quickly adds up to a lot more work for those reviewing your
submissions.
