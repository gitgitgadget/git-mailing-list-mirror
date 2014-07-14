From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 00/48] Use ref transactions
Date: Mon, 14 Jul 2014 09:16:38 -0700
Message-ID: <CAL=YDWkQXA=XpaV=u8MbrUTkg1DARdDuNGbY_qPjyNZOF+D4Yg@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<53BC1C53.9030203@alum.mit.edu>
	<xmqqa98jadqx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 18:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ivj-0008VL-Kz
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 18:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012AbaGNQQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 12:16:40 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:45342 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836AbaGNQQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 12:16:39 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so953916vcb.37
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TyZ9nF0n2QRwlafkfmJW7GFc6sKLx95cMF/guPKoewE=;
        b=GarxQtdl/7lKUsY3gK6mP5zt9iPOA9chBlZY70Ee9pK2uSIWUOCBLjmGir7CyFjafy
         IcRtoR3zHq1Bb3bZsPIBCzjhkbTm7UT52G7/lgN31ODUvfbf7Gvq4HTod7TBSjLFQcqO
         7b222k5czqMngwcq0mfN7B8UUhASppjBu7XtfR2ItcUkf2RrQXPK3RN3SxnwBNP8mYO1
         efJ34cqlmLao+i/QuKdmjXWn4LeLmBmQWQmQLYcqXwIMOltp51SfcyF7cHH4UmvYVIVb
         snbOwE06i+aheBXOowjTnnvqfEkFDL+lgHNTJsyQbvs2JDTCBpQgtbQTuRVWrJIqBL8d
         MUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TyZ9nF0n2QRwlafkfmJW7GFc6sKLx95cMF/guPKoewE=;
        b=dZunbvlBsvjWROhh7yvyjIKhvp2J8nb/a3l3TNHRIGoPEbdquXotAgmOv4ciOW+H4Q
         T7NtOQk0SoyKn9N3nFwY79DdlY9Yu663weRG7yDjCVP2GGSYOZJKgtkb6TqFvDkwcP0t
         U1DYn9bfPJp1ZbLzS6A43x5/HvYU+8kSQDlj6ChTkRcfk9acI1HIhgIQiJDwNGZDCkdP
         KZIWtGz12lObINPeGEteYcArY2Pc5XSQfJKbjJ+WXwfQOFkGvCoY3oYJIqTr0sg51AAo
         CGOCo0w6y3rPgkcLr/B4VRnlIsd96bH9QLKw3iPDcS6CRxDYsAM2VwkLuCSQti4UEM2c
         3Gvw==
X-Gm-Message-State: ALoCoQnZTMLLampvue1ApGo2u1gWk65pNQRGZVnd3Zd5c/7de13bR/z5i1yB/nb2Qypndn8qrISX
X-Received: by 10.58.197.193 with SMTP id iw1mr1047269vec.57.1405354598524;
 Mon, 14 Jul 2014 09:16:38 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 09:16:38 -0700 (PDT)
In-Reply-To: <xmqqa98jadqx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253496>

On Tue, Jul 8, 2014 at 11:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Patches 01-19 -- ACK mhagger
>> Patches 20-42 -- I sent various comments, small to large, concerning
>> these patches
>> Patch 43 -- Needs more justification if it is to be acceptable
>> Patch 44 -- Depends on 43
>> Patches 45-48 -- I didn't quite get to these, but...
>>
>> Perhaps it would be more appropriate for the rules about reference name
>> conflicts to be enforced by the backend, since it is the limitations of
>> the current backend that impose the restrictions.  Would that make sense?
>>
>> On the other hand, removing the restrictions isn't simply a matter of
>> picking a different backend, because all Git repositories have to be
>> able to interact with each other.
>
> I'd say that "if you have foo/bar you cannot have foo" may have
> started as an implementation limitation, but the interoperability
> requirement with existing versions of Git and with existing
> repositories makes it necessary to enforce it the same way as other
> rules such as "you cannot have double-dots in name, e.g. foo..bar"
> or "no branches whose name begins with a dash", neither of which
> comes from any filesystem issues.  That a rule can be loosened with
> one new backend does not at all mean it is a good idea to loosen it
> "because we can" in the first place.

ACK.

>
>> I think it would be good to try to merge the first part of this patch
>> series to lock in some progress while we continue iterating on the
>> remainder.  I'm satisfied that it is all going in the right direction
>> and I am thankful to Ronnie for pushing it forward.  But handling
>> 48-patch series is very daunting and I would welcome a split.
>>
>> I'm not sure whether patches 01-19 are necessarily the right split
>> between merge-now/iterate-more; it is more or less an accident that I
>> stopped after patch 19 on an earlier review.  Maybe Ronnie could propose
>> a logical subset of the commits as being ready to be merged to next in
>> the nearish term?
>
> Yeah, thanks for going through this, and I agree that we would be
> better off merging the earlier part first.
>

Ok,  01-19 is as good split as any.
If you merge just the 01-19 part of this series I will address
Michael's concerns and repost patches 20-48 as a separate series.

regards
ronnie sahlberg
