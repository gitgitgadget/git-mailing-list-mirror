From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Mon, 10 Jun 2013 11:39:04 +0200
Message-ID: <20130610093904.GG2091@goldbirke>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
 <1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
 <7vd2rvqgra.fsf@alter.siamese.dyndns.org>
 <CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
 <7vy5ajozuj.fsf@alter.siamese.dyndns.org>
 <CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
 <7vfvwrowd0.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Qr54+8hbkZ+jmXB628SCPwg1zZo80UBhFe2PCrgQP4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 11:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlyZF-0001iF-3s
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 11:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab3FJJjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 05:39:09 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:57351 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab3FJJjI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 05:39:08 -0400
Received: from localhost6.localdomain6 (g227025092.adsl.alicedsl.de [92.227.25.92])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LZjNw-1U4xhV0XHA-00m5gV; Mon, 10 Jun 2013 11:39:05 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s0Qr54+8hbkZ+jmXB628SCPwg1zZo80UBhFe2PCrgQP4Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:lZcrQrvt51vhFjQbx5WFRwBl+Br14RgYlJ8OBkhlQ8C
 51RoSCX1ms4f6c38eirQb1Pk1XDItheFL1VGKnHTpft2LRnB5g
 p1adaIj8AogRorb07H9eImirbroh2vGuPuKBdFfxs/Bbbw6w2g
 22JV7diIJOoZW42Yzgk7aaa6ylz1ZcZHqQhoBJBkGHljTAarHt
 csZzT1Wm7t9f8l80Dhwonr6RDU5SE/CLby4KjM49UPt/1EepsQ
 Aou1ZCalWj/npqkmvDqOHZqgcNTtmLj8CxMvPrMZDnLaymH2DU
 IDtOfKeqkkEPuzAVvgsK72M+UJkdqbK0JJZWOdcmhovwisv89r
 aTNtL2Hz34qNy1ms2zsQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227269>

On Sun, Jun 09, 2013 at 03:41:54PM -0500, Felipe Contreras wrote:
> There
> will not be a need for test_string_must_be_empty() just like there's
> no need for test_string_cmp().

Actually, if there were a test_string_cmp(), that would be the test
helper function I used most often.
