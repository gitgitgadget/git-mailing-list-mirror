From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Sat, 16 Jan 2010 12:55:12 +0800
Message-ID: <be6fef0d1001152055j2f178ecifc8e0265446ab75f@mail.gmail.com>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <7vzl4frl7i.fsf@alter.siamese.dyndns.org>
	 <7vfx66sz5p.fsf@alter.siamese.dyndns.org>
	 <20100116090321.6117@nanako3.lavabit.com>
	 <7vk4virjzh.fsf@alter.siamese.dyndns.org>
	 <be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com>
	 <7vhbqmn9c4.fsf@alter.siamese.dyndns.org>
	 <7vljfyiswv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 05:55:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW0gy-0006YA-Em
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 05:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735Ab0APEzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 23:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755134Ab0APEzO
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 23:55:14 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:48863 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab0APEzN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 23:55:13 -0500
Received: by iwn35 with SMTP id 35so1026020iwn.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 20:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=9b8B9H1Rzx8TtVA8MnmLCv20waZpjylLBFpWV7cuDsg=;
        b=tLgFgB/FPUUZ+uMiUwmqtOKDAIP5oE6wwe1m4p7rpDVg60YUYK5VNUGhANwsGw1R1T
         uNKUeOiyiTn5v7aIL9JxRh3Cwb3Dj3/8xRgix9aEKaibKHyuuUW+kJfqK0lUCrbXIgyy
         thUFOg1NhfscFuZRcaf/e4HUjn36TT7xgHq/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Sbb0td2IMxkDW7q/y70G+7UnruqpZLhvo8WSSLGB2DOiSZI1N3pVlHAL0XhYNa0Gz/
         i9m0lKCb3fn0q9fEToK+izvgo7R4abVuEeo7O3Z8LBq5eLHqQWvzzc5BtJLeK2EttkdL
         vM9QYSzmB+itO+37abgfdfzOj0xi5MfjKJzP0=
Received: by 10.231.40.216 with SMTP id l24mr3331255ibe.40.1263617712118; Fri, 
	15 Jan 2010 20:55:12 -0800 (PST)
In-Reply-To: <7vljfyiswv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137201>

Hi,

On Sat, Jan 16, 2010 at 12:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Tay Ray Chuan <rctay89@gmail.com> writes:
>>
>>> After all, there's already the config called branch.autosetupmerge and
>>> branch.autosetuprebase.
>>
>> Do you mean Ilari's patch already sets up branch.name.rebase for people
>> with branch.autosetuprebase true?
>
> I checked; the patch uses install_branch_config() so it should get this
> right automatically.

ok, then ignore my suggestion about --setup-merge and --setup-rebase.

I guess Nanako's query about 'pull --rebase' is settled as well.

-- 
Cheers,
Ray Chuan
