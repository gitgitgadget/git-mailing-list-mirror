From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Tue, 22 Feb 2011 21:24:40 -0800
Message-ID: <7vpqqj9vc7.fsf@alter.siamese.dyndns.org>
References: <4D0ED5EC.9020402@burntmail.com> <4D119015.6020207@burntmail.com>
 <4D2AB63D.7040803@burntmail.com>
 <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com>
 <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino>
 <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com>
 <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com>
 <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com>
 <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com>
 <7vy65bkw72.fsf@alter.siamese.dyndns.org> <4D61EA4B.3020708@burntmail.com>
 <7vtyfxgdz2.fsf@alter.siamese.dyndns.org>
 <7vipwbbrcc.fsf@alter.siamese.dyndns.org>
 <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC-32@mail.gmail.com>
 <4D644FEE.5030004@burntmail.com> <7vaahnbmu2.fsf@alter.siamese.dyndns.org>
 <4D6471E8.4060001@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Guy Rouillier <guyr@burntmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 06:25:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps7Do-00009v-7O
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 06:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914Ab1BWFZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 00:25:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1BWFZA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 00:25:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E37BE4361;
	Wed, 23 Feb 2011 00:26:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOAhctXBAetcCEDlDdkwQEYxD9o=; b=JeU/mQ
	MGwcYvZ9TirUJSubZmMteMLQBI1jCIdqkf+sTByXX4JgpmQOT11O1IjbJQIzA67X
	vh1uqkKNg/7KnjbUDGc2uEPhrnGNwAGqM0EBhZzYDWTdu4euRt3Z8BA9KER7n4Ky
	etBzSfVUHIweqhjgPsK6Up596EkATJNT/+Sdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qw4g2xj3eZtxUhBgjTl+US3Jixc40msn
	ewrEZY6ACnKAGrKHcsw8JYjX+TUgP+WPO8DkWrESoDWA6UAM1RrT1VuQsO0v/19d
	vHi9fkcZkS++mgH+/6UZlep5Yrvda4al6T3ZhadI4ntqXZoekC3NDzuIXA3iVISe
	ljmLmfpZDx8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73CD3435E;
	Wed, 23 Feb 2011 00:26:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 63481435B; Wed, 23 Feb 2011
 00:25:54 -0500 (EST)
In-Reply-To: <4D6471E8.4060001@burntmail.com> (Guy Rouillier's message of
 "Tue\, 22 Feb 2011 21\:33\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 681384EA-3F0D-11E0-85C6-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167674>

Guy Rouillier <guyr@burntmail.com> writes:

> ... Note that this issue is not unique to CVSNT.  What does
> CVS do with CVSROOT containing a space character?

IIRC, the comparison is done against canonicalized cvsroot string, so that
you can try to connect to :pserver:Xz.Com:/path/to/repo even after you ran
"cvs -d :pserver:xz.com:/path/to/repo login" and I wouldn't be surprised
if the canonicalization involved quoting SP.  Since August 2009 nobody has
complained with the current code that doesn't do any canonicalization, and
I take that as a sign that nobody sane so far used a cvsroot with a space
in it ;-).  But that doesn't mean nobody sane has been using a cvsroot
with an equal sign in it, so we would need to at least avoid splitting at
an equal sign when reading from .cvsroot.

It probably is a good idea to port the cvsroot canonicalization code to
cvsimport in any case.
