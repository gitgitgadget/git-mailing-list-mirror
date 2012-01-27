From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] svn-fe updates for master or next
Date: Fri, 27 Jan 2012 10:39:11 -0800
Message-ID: <7v39b10z3k.fsf@alter.siamese.dyndns.org>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
 <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
 <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
 <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
 <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
 <3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
 <CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
 <CAFfmPPPvpbsYz9cjN6OspivCN3dbuPGOU7fyaVdnic3D4V855w@mail.gmail.com>
 <20120127001041.GB6158@burratino> <20120127003258.GA6946@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <davidbarr@google.com>,
	Scott Chacon <schacon@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>, david@lang.hm,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 19:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqqhk-0000Lf-Kr
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 19:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab2A0SjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 13:39:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049Ab2A0SjO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 13:39:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E215C6F4E;
	Fri, 27 Jan 2012 13:39:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2dCQlG+M/VXU+qx1H9XnDaDKMs4=; b=UOCBP6
	yO5M1V9+XGF5Yclp/tJI3mBm6pc0B4+LYwaLGpAmwFa/Gb4XTpkJxXRcNNzBK7yG
	Qkw6Pm/nz4uHjvb1ku++sO7KNIp8bI9NNanDgGg/4LZRaCWB+72KTcGTAn0kiCgY
	Rq1O8XnMVkDsk8pZJ7JtmAg4/NPktnh0oZzEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NEJgVnO2bHK30MA40+TT7NpaVGi+93s9
	DMHdXX4r65TaLG/Q9OpuN+IcgmEI9ZiZCWf2JvUqOxCFy4q25+Mo/Te9PtG5acVZ
	6RE/7Kj6M3LvGOIAPuZF6xRhMxDuQDCh8NCG6G6alxHaZSzS4hqp64pzz4C9/ODp
	AxqQb+Sn0ck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D71096F4D;
	Fri, 27 Jan 2012 13:39:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 581386F43; Fri, 27 Jan 2012
 13:39:13 -0500 (EST)
In-Reply-To: <20120127003258.GA6946@burratino> (Jonathan Nieder's message of
 "Thu, 26 Jan 2012 18:33:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3587D58A-4916-11E1-990E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189229>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio, please pull
>
>   git://repo.or.cz/git/jrn.git svn-fe
>
> to get the following changes since commit ec014eac0e9e6f30cbbca616090fa2ecf74797e7:
>
>   Git 1.7.5 (2011-04-23 23:36:32 -0700)
>
> up to c5bcbcdcfa1e2a1977497cb3a342c0365c8d78d6:
>
>   vcs-svn: reset first_commit_done in fast_export_init (2011-06-23 10:04:36 -0500)
>
> I'd even be okay with pulling this for v1.7.9, but application for the
> next release would also be fine with me.  It simplifies svn-fe a great
> deal and fulfills a longstanding wish: support for dumps with deltas
> in them.  The cost is that commandline usage of the svn-fe tool
> becomes a little more complicated since it no longer keeps state
> itself but instead reads blobs back from fast-import in order to copy
> them between revisions and apply deltas to them.

Thanks, but will pull after 1.7.9 that was scheduled to happen today.

By the way, we should have done a GPG keysigning at the last GitTogether.
The above paragraph ("The series simplifies svn-fe a great deal...") could
have been recorded in the message body of a signed tag, and we could have
started eating our own dogfood, now even Linus and his lieutenants are
using the upcoming 1.7.9 feature.
