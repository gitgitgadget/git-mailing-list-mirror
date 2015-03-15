From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 03/16] list-files: show paths relative to cwd
Date: Mon, 16 Mar 2015 06:41:08 +0700
Message-ID: <CACsJy8CX0WJryLV5C6=0pV=Ssgp3uxpF0pYX5Q1eKHOedAFOzg@mail.gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
 <1425896314-10941-4-git-send-email-pclouds@gmail.com> <xmqqsid929rb.fsf@gitster.dls.corp.google.com>
 <xmqqoanx29ei.fsf@gitster.dls.corp.google.com> <CACsJy8CjcCuDC8X9E5iko2b8xykBAwMY1JupYx1dzpnf5p5ghg@mail.gmail.com>
 <xmqqh9tmt0zt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 00:41:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXIAB-0006ei-SI
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 00:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbbCOXlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 19:41:40 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33594 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbCOXlj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 19:41:39 -0400
Received: by ignm3 with SMTP id m3so22612461ign.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dA7/ZmPjnZx0M73vDM525BBGZhbWRwW4ArbvJVqKUvM=;
        b=FejVh9XEyfEFcJNnDpjut/WuejjGGMCoTIDXUHG8X8/E1ARtWlkg4WBTAUCIoqJkeG
         TKG8aMq2BDowjdSQj+NUCtHy3jakcUvVpZCZCWyGTE+8e/l1Ecvd5GrpPY3LkuVCpEUt
         xMdrukKzGBmnHbR9No0hNEdpSP9542zR6su2RCEJ4UzHVdr96vC3oDmel0gG5VpwCKG5
         h+mgKW8V9h++8tIbRJxh15g8dtqSOZzp3ubSizh5j4aZebHZB9sdWHm/ec0wth7Hzpnm
         6LoAXeULimRkdHM4nTnOJ+SyAhilu9JjodiYJlOdp8D05ACp5hqSqpFtJTLkxQb21HOy
         BPEg==
X-Received: by 10.50.234.194 with SMTP id ug2mr131162505igc.39.1426462898384;
 Sun, 15 Mar 2015 16:41:38 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sun, 15 Mar 2015 16:41:08 -0700 (PDT)
In-Reply-To: <xmqqh9tmt0zt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265534>

On Mon, Mar 16, 2015 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Exactly. We would need to sort and stuff later on, so true filenames
>> are preserved in util->item. A cleaner way is perhaps carry all
>> metadata in item->util and item->string remains true filename, then do
>> all the formatting, coloring for all strings just before displaying.
>
> I guess we are then in agreement with my review comment on [04/16].

Yes. I'm redoing it. I will probably stop using string-list as well
(it's inherited from the old code), just an array of struct.
-- 
Duy
