From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] git-prompt: cleaning and improvement
Date: Fri, 28 Jun 2013 10:13:33 -0700
Message-ID: <7vsj02p39e.fsf@alter.siamese.dyndns.org>
References: <cover.1372211661.git.erdavila@gmail.com>
	<7v8v1vvash.fsf@alter.siamese.dyndns.org>
	<CAOz-D1JE2YkoJErY_yjvBC-YSTC=7RycB3svnQ0t3c4RMVOJPw@mail.gmail.com>
	<20130628094221.GA15436@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Eduardo R. D'Avila" <erdavila@gmail.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 28 19:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UscEu-0006kd-LR
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 19:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab3F1RNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 13:13:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398Ab3F1RNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jun 2013 13:13:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9019E2966D;
	Fri, 28 Jun 2013 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6EDecvU5G9C8
	AfOA6AcFAwryvKc=; b=EBvMWHStzNSSSufWdG9A4xnmc5Yf6/0H64FWv4eoI9ME
	9t4tO2p1j8HjYt9DHlfqQ5BOHm1n9qhrJYekpNSamJ9WBoiWUz69PPK4/poRF+Qw
	MVJx0MPoI5rp+o8yF79DJw1SJQfGP5AC7JK7DkEMhJjaauqndVe6Vba/bN7Xp5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oMaMiK
	sIdCCWqgVAlXDEv22imfzbx2XIm45ZXKcKV5h/cW4HNomFTDYNUFGqPxOtn7S+Hk
	etPbxPX3CTBccRFpyrGuxjyh2nR6MvzIuoMZruqGIDcxDSUWr3o+xHIENrXXeegd
	lgViq3INFy6+U6vDFn96yNLakCod1X06vYwsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 847CD2966C;
	Fri, 28 Jun 2013 17:13:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08DD729669;
	Fri, 28 Jun 2013 17:13:34 +0000 (UTC)
In-Reply-To: <20130628094221.GA15436@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Fri, 28 Jun 2013 11:42:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10CF1C7E-E016-11E2-8B8F-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229216>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Thu, Jun 27, 2013 at 10:31:57PM -0300, Eduardo R. D'Avila wrote:
>> The merged result is ok!
>
> Yeah, it look good, thanks.

Thanks, both, for double checking (and thank you for preparing the
pre-merged results).
