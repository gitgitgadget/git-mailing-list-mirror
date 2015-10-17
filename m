From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: git tag --contains now takes a long time
Date: Sat, 17 Oct 2015 23:40:23 +0530
Message-ID: <CAOLa=ZSjNjey3zWozFkyFw-X-BPtsVNpQKqG5hO9-7qJOBR_KA@mail.gmail.com>
References: <20151016220739.GF17700@cantor.redhat.com> <CAOLa=ZTDd3MSmqXArtNz8i5n=uj2NEB6UPk2jSnEhUsAqbr7nQ@mail.gmail.com>
 <vpqmvvhpjv2.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, Git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 17 20:11:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnVwZ-0002iA-84
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 20:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbbJQSKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 14:10:54 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33674 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbJQSKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 14:10:54 -0400
Received: by vkaw128 with SMTP id w128so84862252vka.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NsYxkEMougOLV+eeuXoSplHi8TvkR/UP/xt5O87Gb+Q=;
        b=LwU4ruoE9Gqf7iSvmwoa8th+5zwmh0G7wJ21AXmxhyXBIrs8MHp60HDKZ+BIW33K6B
         5fi9swMpgXVjiCEyQW042w4SQ/MQep7GGL9TyfaeMkUd7MHz438GU9cmviz/UPI68bhW
         h/p1r76o3yH6aJpSgxDAM6LhtLDn4D0xZXr8iz29EIrApFBWhZW7nDD3YEYlXKLGZYGb
         zENnnchY3BVqyBr87QvPV6mzGrJmtLAKx7W7oPsXqD2Clz1YV56ub8MOE7OO54EzX34k
         eA4+hkB6xBkAKqCrr44wHJm6YD6+kNmp4AuZ7ePIEP3KVkxVBIpBLhP1WbDhlRgscVYV
         PsMg==
X-Received: by 10.31.47.5 with SMTP id v5mr13101069vkv.146.1445105453163; Sat,
 17 Oct 2015 11:10:53 -0700 (PDT)
Received: by 10.103.65.76 with HTTP; Sat, 17 Oct 2015 11:10:23 -0700 (PDT)
In-Reply-To: <vpqmvvhpjv2.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279791>

On Sat, Oct 17, 2015 at 9:28 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Could you Squash that in, Junio?
>
> The guilty commit is in master, so you'll need a new commit to fix the
> old one. Can you send a patch with a proper commit message (referencing
> b7cc53e92c806b73e14b03f60c17b7c29e52b4a4)?
>
> We should both have catched this earlier (by review and/or benchmark).
> Sorry we didn't, and thanks to Jerry for the report.
>

Yea, I'm surprised we didn't notice. Either ways, I'll reply with a
fix commit :)

-- 
Regards,
Karthik Nayak
