From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 08/19] parse-option: rename parse_opt_with_commit()
Date: Mon, 22 Jun 2015 22:07:41 +0530
Message-ID: <CAOLa=ZQ1s01vzwwSToocr1-SBESTv1zYAVB=BKWdqz6SF7fSeA@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-8-git-send-email-karthik.188@gmail.com>
 <CAPc5daVpqDC4K6ne=E_cdzG0NhfEYLucWdxVwKMf9WtDxzPUnA@mail.gmail.com>
 <CAOLa=ZQZ763F9AFpkGZ-ay2_q_3YCYXMuf_gYg-sQd=N-kyebA@mail.gmail.com> <CAPc5daUWFx0YDHfRJynCiw7cBwDrDzyrY_TNDDBaDCVCDJb3ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 18:38:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z74jf-0001sC-U1
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 18:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbbFVQiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 12:38:12 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36126 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbFVQiL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 12:38:11 -0400
Received: by obctg8 with SMTP id tg8so116854199obc.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4tGS7MjzHbeck6gyfYY2FXznCnrDw+rWBCNztjxXDXw=;
        b=r1Biu3hu5T5ectwC+DTiB7jfUJNb3aLvcsFGy9IhuirFcVwkY/SmrpRcOZJ/0jnygI
         h/feSBrsAhZq72HpNAO4SIE3ElQ0yWYLUuRw3cAVeu/oVygSy1DFDJYR76l30JvjeLUT
         g/QirhEykStpAK/Gpl04UBlMVhOYtTPeSMoLCVj5BfIQzGczKxoe/yybMR6FQJ/vm4Bo
         m7XNaqfBftB+X6ZIunGqTE5p6LPTedyqbNU0cfucS6xRsqEeTgcE6mMJWFLknB60FhHb
         a4IJ4jUb3nYft4VXMmelR6dgTVe6cam67vKgn+ce1YYQs6d/LhOMtNGimveDq3Hp3nZL
         /r+w==
X-Received: by 10.60.35.8 with SMTP id d8mr25828041oej.37.1434991090676; Mon,
 22 Jun 2015 09:38:10 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 22 Jun 2015 09:37:41 -0700 (PDT)
In-Reply-To: <CAPc5daUWFx0YDHfRJynCiw7cBwDrDzyrY_TNDDBaDCVCDJb3ag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272397>

On Mon, Jun 22, 2015 at 9:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Jun 22, 2015 at 8:38 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Mon, Jun 22, 2015 at 6:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> On Sun, Jun 21, 2015 at 1:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> Rename parse_opt_with_commit() to parse_opt_commit_object_name()
>>>> to show that it can be used to obtain a list of commits and is
>>>> not constricted to usage of '--contains' option.
>>>
>>> I think that is a brilliant idea, but unlike the other function you
>>> added earlier
>>> that can do only one object and adopts "last one wins" rule, this is cumulative,
>>> and that fact should be made clear to the developers in some way, no?
>>
>> Will add a comment
>
> I didn't mean that. Can't we indicate this with plural somewhere in the name?
> parse_opt_commits(), parse_opt_commit_into_list(), etc.?

Definitely! thanks :)

-- 
Regards,
Karthik Nayak
