From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Multiple line ranges and files in line level history browser
Date: Tue, 11 May 2010 01:28:28 -0500
Message-ID: <20100511062828.GA29615@progeny.tock>
References: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
 <20100509210654.GA1637@progeny.tock>
 <AANLkTim0MUq7JiKQavArUcxZxu7hvXUrO_AdEX6JbcVv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 08:28:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBixA-0004x8-FN
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 08:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930Ab0EKG2X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 02:28:23 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:63936 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab0EKG2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 02:28:22 -0400
Received: by yxe1 with SMTP id 1so3309759yxe.33
        for <git@vger.kernel.org>; Mon, 10 May 2010 23:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=djRldVXYmc3Y/tgHreUBFmpmzP7QDTvmGvWD3aQVFGs=;
        b=APn3W9UvHvTBkB/KWf7NO2Q+d4nJ36jMMaKo81D+3UNMvxsabXA8HA3Ntq6bXXapF9
         masQftbewBFCBKdac2T5ktuzIH+boOU26hQGH9mqHSSj4ZDRHTag5YHduO7SLoyvrP16
         B2IK6X0RS9BuMro9TuTS048g1daNnrnW2yh5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oF/Ax7KzMZC+2zvOGXY15zVq57hYFadQXKGy5JR5Y8hOllx0v4ctaRWrE3d5q6iBF2
         pk1ZOE+FiZu3oZnMCB75Z1EwRh70YpUt2M+ozMZJKPDXNXu/yVRp6aasiRUg1ZlIxVvU
         gdcUHmieD7zVvVaVcxIWj9G3YyIoqIf/KkR9U=
Received: by 10.101.134.6 with SMTP id l6mr1390681ann.50.1273559301765;
        Mon, 10 May 2010 23:28:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4179373yxe.5.2010.05.10.23.28.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 23:28:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim0MUq7JiKQavArUcxZxu7hvXUrO_AdEX6JbcVv@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146874>

Hi,

Bo Yang wrote:
> On Mon, May 10, 2010 at 5:06 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =A0# who wrote the opening comments?
>> =A0git blame -L '/^[/][*]/,/^ [*][/]/' -- '*.c'
>
> I think users can always use a little shell script to achieve this, w=
e
> should not bother to implement such a complex thing which can be
> easily done by shell script.

True enough.  Thanks for the sanity.

Jonathan
