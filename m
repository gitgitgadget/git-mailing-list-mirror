From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-fetch should not strip off ".git" extension
Date: Wed, 22 Oct 2008 00:06:55 +0200
Message-ID: <81b0412b0810211506y400ba750k2613ba19f01fb57@mail.gmail.com>
References: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
	 <48FC5F1B.1050608@op5.se> <7vzlkz2jv7.fsf@gitster.siamese.dyndns.org>
	 <ee2a733e0810210323j249c3460x881af6d6aefc647c@mail.gmail.com>
	 <7vej29zy2r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: SLONIK.AZ@gmail.com, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 00:08:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsPOe-0007Uf-Dd
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 00:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYJUWG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 18:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbYJUWG7
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 18:06:59 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:42475 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbYJUWG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 18:06:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so151602and.103
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=W7U/bWpH635TItDzhgqKLJZKjYON74ViJ75xuCszoSE=;
        b=BCyO8/et1VcVcBjt24ranQ5djo1qZdQqBaNkfw2arIkYkr42i8Lixc102wN1YWEaK5
         x2GHTBlJ0Q2pqQSOh5nw535PiOB+/WgvmnrVYsuQkRYxI2swEMjezZNT5jwfv92Nb89p
         Jo4pXn2jfqWqS7SYD4j9Re0GPoymFgk2ohqiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sz8bFwy2Ob4aB2ELU99spFjy0LV6lvfcpoRqmwRjRBZMrGfiqTUsCf3PCECmHZGKbh
         21UuGEgxz0TPRpDvZ7w7/8J9ETpb60wPpQ3A2stXdazmBfeeGrnN/E+377EvpsXW1gqQ
         L6AGTdvRzchqXf6mb+gV1mtEGWLcwHAUES5kA=
Received: by 10.100.43.10 with SMTP id q10mr9303691anq.1.1224626815591;
        Tue, 21 Oct 2008 15:06:55 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Tue, 21 Oct 2008 15:06:55 -0700 (PDT)
In-Reply-To: <7vej29zy2r.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98821>

2008/10/21 Junio C Hamano <gitster@pobox.com>:
> "Leo Razoumov" <slonik.az@gmail.com> writes:
>
>> Even though the old behavior is "long established", it introduces
>> unnecessary ambiguity. If I have two repos
>> ...
>
> Of course.  Now you know why people don't name such a pair of repositories
> like that ;-).

FWIW, I support Leo on that. The "established" behavior is stupid.
