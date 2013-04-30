From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 16:24:08 -0700
Message-ID: <7vy5bz8uw7.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
	<CAMP44s2S4AtZUfH4NWCLt=p49QXeYSZKELYbahpBUgDofaFMsw@mail.gmail.com>
	<7vsj27ac2a.fsf@alter.siamese.dyndns.org>
	<CAMP44s3=frHWUh8rQ5kTooUJqwAtkEG37MaeY3Ho6G7-kwZQ_w@mail.gmail.com>
	<7vbo8vabet.fsf@alter.siamese.dyndns.org>
	<CAMP44s02QkL7QAuHHm_uT6B4QCzk9Mur0_w_D8t2A2u1go2F8A@mail.gmail.com>
	<CAMP44s3L6X=iWK7S-JFqp42PmNx4xbh-GnPJpAgur4FGoZYNbg@mail.gmail.com>
	<CAMP44s3QT5z1iWsm0cvQDfmZBp_kWbXatQKGaj8H3kzgdK=QFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 01:24:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJuC-0006Qs-S5
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 01:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933943Ab3D3XYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 19:24:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933926Ab3D3XYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 19:24:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 186ED1B8BB;
	Tue, 30 Apr 2013 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sBwRSwKpdEylCjAUshkFddk6a8s=; b=vh1BuL
	MONKj5Yo6b+M77kJ9W8NFY76AuDWaoVB/NrdEQyMi+SaqqbBLJeTEMN9x2/KqPES
	bC+gWQ1H3v6yhHxaYyaopjlMHWzgm+x/Jf7amB0o+ijHNZTXbXarETs5OUDqupJa
	NdVSMHa8r9q7fMbuRxNkEiIhPh7Psh20HzW1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pn+CGj4+aVFzQLh196vgQRZbYWWEXn2M
	XW8R+7ZUgkW2ErJCy+rIlLSBAhg1KtdcuDenqLsQpJwng/4utsal+wIRvhriHY7B
	EdVc+ofkjJHw4/xBhr8TRDzdizAcaEP2rb2OzlarEACTc0zM5rgF3I4qsOQ3Wg0U
	f8GPLxdGYCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F1571B8BA;
	Tue, 30 Apr 2013 23:24:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6812C1B8B7;
	Tue, 30 Apr 2013 23:24:10 +0000 (UTC)
In-Reply-To: <CAMP44s3QT5z1iWsm0cvQDfmZBp_kWbXatQKGaj8H3kzgdK=QFw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 18:19:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FC3910E-B1ED-11E2-BEF7-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223043>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Apr 30, 2013 at 6:00 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> +static int interpret_empty_at(const char *name, int namelen, int len,
>> struct strbuf *buf)
>> +{
>> +       if (namelen - len < 1 || name[len + 1] == '{')
>> +               return -1;
>> +
>> +       strbuf_reset(buf);
>> +       if (len == 0) {
>> +               strbuf_add(buf, "HEAD", 4);
>> +               return 1;
>> +       } else {
>> +               strbuf_add(buf, name, len);
>> +               return len + 1;
>> +       }
>> +}
>
> Hmm, it's not correct, and besides, if we don't parse 'master@', it's
> much simpler:
>
> /* parse @something syntax, when 'something' is not {.*} */
> static int interpret_empty_at(const char *name, int namelen, int len,
> struct strbuf *buf)
> {
> 	if (len || (namelen > 1 && name[1] == '{'))
> 		return -1;
>
> 	strbuf_reset(buf);
> 	strbuf_add(buf, "HEAD", 4);
> 	return 1;
> }

I'm done with today's integration cycle and pushed the series
without these updates out on 'pu'.  Hopefully you will have a "drop
the last N and replace them with this" update after finishing these
experiments by tomorrow? ;-)

Thanks.

People who wanted to see some form of typesaver for HEAD, please
poke at the implementation and see if there are cases where @ should
be interpreted as HEAD replacement but isn't (or vice-versa).
