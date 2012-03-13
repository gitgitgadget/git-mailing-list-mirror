From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Tue, 13 Mar 2012 12:32:56 -0700
Message-ID: <7vobs0uwif.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
 <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
 <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
 <7vd38okmp0.fsf@alter.siamese.dyndns.org>
 <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org> <4F5BD585.5050007@web.de>
 <4F5CC08C.90703@web.de> <7vzkbnvt6m.fsf@alter.siamese.dyndns.org>
 <4F5D14CD.6080507@web.de> <7vzkbmvmvx.fsf@alter.siamese.dyndns.org>
 <4F5E6362.7050001@web.de> <7vmx7lpl5a.fsf@alter.siamese.dyndns.org>
 <4F5F9DD1.50907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 13 20:33:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7XT0-0007qX-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 20:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255Ab2CMTdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 15:33:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932243Ab2CMTc7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 15:32:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCCD27D21;
	Tue, 13 Mar 2012 15:32:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1uYqTNQMMl7M
	7B9kC+VGNDXAy8Y=; b=gfbQT9AJVrnaLKsxOvs5thhXSqfOCh2wJ73MBELYjyzC
	b/+OwnaP0loRSgii+PyDD5OVhx9d7VU7S+g87cDxguu4rndl1j5LfYUVfOBO0Wbq
	0XFStosVtWXNOPTiq2ik/xg5n0RQxNWTNi3iT1vJBAO0fSZaiYOn1/zv7SvTJyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Zucg++
	sRKHrFrHrZZY6z4m+sbLVwkhNHE2rvRTp5zmMQtHYXtB9Wsq7Ed4j+AhTR+1K6Ah
	hvDiIsn79R6SQ5qjCfMY0ojzCU0w14deRwlOzCGtp16U+Y1ug9xI14McVEZImE5I
	JCbxPkuoMwPHK2o86r864CoRPXx5cA1kmXdBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B47797D20;
	Tue, 13 Mar 2012 15:32:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 254647D1F; Tue, 13 Mar 2012
 15:32:58 -0400 (EDT)
In-Reply-To: <4F5F9DD1.50907@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of "Tue, 13 Mar 2012 20:19:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56A3B62A-6D43-11E1-B365-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193061>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> -- >8 --
>> Subject: i18n: fix auto detection of gettext scheme for shell script=
s
>> ...
> Thanks for the patch. Here are the results of t0204:

So in short, "everything looks peachy with the patch" seems to be the
conclusion.

Thanks.
