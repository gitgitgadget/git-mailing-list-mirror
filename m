From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/14] Remove unused code from imap-send.c
Date: Mon, 14 Jan 2013 10:33:33 +0100
Message-ID: <50F3D0ED.5030103@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu> <20130114065757.GK3125@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 10:33:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TugQX-0005F9-5Y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 10:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163Ab3ANJdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 04:33:37 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:42803 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756087Ab3ANJdg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 04:33:36 -0500
X-AuditID: 12074414-b7f9b6d0000008b3-16-50f3d0ef48b5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.B3.02227.FE0D3F05; Mon, 14 Jan 2013 04:33:35 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E9XXqc003063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 04:33:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130114065757.GK3125@elie.Belkin>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqPv+wucAg/UzjSy6rnQzWTT0XmG2
	eHtzCaPFj5YeZgcWj52z7rJ7POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGb2rHrMW
	bGatmLt1KUsD42qWLkZODgkBE4kNE86xQthiEhfurWfrYuTiEBK4zChx5ttmKOc4k0Rz008m
	kCpeAW2Jz68PMIPYLAKqEosmXwfrZhPQlVjU0wxWIyoQILF4yTl2iHpBiZMzn4BtExHQkHj+
	6RsbiM0sEC+xafIEsDnCAnYSK/r2A/VyAC3LkHjcYw4S5hQwkNi99BETRLmOxLu+B8wQtrzE
	9rdzmCcwCsxCsmEWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSnd
	xAgJZ5EdjEdOyh1iFOBgVOLh3VzyOUCINbGsuDL3EKMkB5OSKG/xGaAQX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEd5pp4FyvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoS
	vG3ngRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQZEaXwyMVZAUD9DexSDtvMUF
	iblAUYjWU4y6HNt/tz9nFGLJy89LlRLnXQBSJABSlFGaB7cClrxeMYoDfSzMWwxSxQNMfHCT
	XgEtYQJasmkv2JKSRISUVAOj3zMhpj+Pvl28nzu99FDvA8WlDCs4p+xIFfDPd4t8939N9uIE
	xp+XP9e9Fdv1nrHjgPSRznNHvA5LFq1bkGgdutzlzXav8iId90lf2/rv793mUjgt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213479>

On 01/14/2013 07:57 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>>  imap-send.c | 286 +++++++++---------------------------------------------------
>>  1 file changed, 39 insertions(+), 247 deletions(-)
> 
> See my replies for comments on patches 1, 6, 9, 11, and 12.  The rest
> are
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> The series is tasteful and easy to follow and it's hard to argue with
> the resulting code reduction.  Thanks for a pleasant read.

Thanks for your careful review.  I will re-roll the patch series as soon
as I get the chance.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
