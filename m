From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 09/17] revert: Don't create invalid replay_opts in parse_args
Date: Tue, 12 Jul 2011 11:27:12 +0530
Message-ID: <CALkWK0m8S3fEFhFQV_A=UNipwa_6yBpdJ1iDc8c6BicthTTSyg@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-10-git-send-email-artagnon@gmail.com> <7vk4bobjjk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:57:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgVyU-0008Cw-8F
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 07:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339Ab1GLF5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 01:57:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53420 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab1GLF5d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 01:57:33 -0400
Received: by wyg8 with SMTP id 8so3020951wyg.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 22:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y6j4GVuwHGNCgrg+PyvkncbB6XuY4PfcSGSUnLrywBg=;
        b=JTmtdI/aKe7a2391R4if2NqVDgzfdnMjSNMVGS/6wfJiKZExvo80fxoc4nmh9z1cYN
         FCK3jxDs88kIWb0PFMPxq7L2ARaRizPtEgxYi2s8gB8ntUk4ouHmZYWIRbvIcs6hyK75
         aR3p3RrexNY/zlC6t0WId3lAgyEpFaJ+Lvpy4=
Received: by 10.216.62.3 with SMTP id x3mr3648021wec.77.1310450252175; Mon, 11
 Jul 2011 22:57:32 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Mon, 11 Jul 2011 22:57:12 -0700 (PDT)
In-Reply-To: <7vk4bobjjk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176919>

Hi,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> structure before before starting its operation, there will be multiple
>
> before before

Fixed.  Thanks.

-- Ram
