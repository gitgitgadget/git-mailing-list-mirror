From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/19] Provide access to the name attribute of git_attr
Date: Thu, 28 Jul 2011 06:27:24 +0200
Message-ID: <4E30E52C.9060407@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu> <1311689582-3116-8-git-send-email-mhagger@alum.mit.edu> <7vr55bo47e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 06:27:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIC6-0000bB-Sg
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824Ab1G1E1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 00:27:30 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:55304 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab1G1E13 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:27:29 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p6S4RPLI005917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 28 Jul 2011 06:27:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <7vr55bo47e.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178005>

On 07/27/2011 10:02 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> diff --git a/attr.c b/attr.c
>> ...
>> +char *git_attr_name(struct git_attr *attr) {
>> +	return attr->name;
>> +}
>=20
> (Style)
>=20
> 	char *git_attr_name(struct git_attr *attr)
> 	{
> 		return attr->name;
> 	}

Thanks.  I will include this in the next version of the patch series.

>> diff --git a/attr.h b/attr.h
>> ...
>> +/*
>> + * Return the name of the attribute represented by the argument.  T=
he
>> + * return value is a pointer to a null-delimited string that is par=
t
>> + * of the internal data structure; it should not be modified or fre=
ed.
>> + */
>=20
> should not be modified NOR freed?

No, usually "nor" is only used with "neither".  I'm confident that the
wording that I used is correct [1].  Alternatively, one could write
"should be neither modified nor freed".

Michael

[1] See, e.g., http://grammar.quickanddirtytips.com/when-to-use-nor.asp=
x
section "When to Use =93Or=94 Instead of =93Nor=94".

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
