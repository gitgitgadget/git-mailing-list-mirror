From: Adam Simpkins <simpkins@facebook.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Wed, 3 Mar 2010 16:36:15 -0800
Message-ID: <20100304003615.GN28452@facebook.com>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 01:36:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmz3O-0008Nw-0Z
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 01:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab0CDAga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 19:36:30 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:54224 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752478Ab0CDAg3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Mar 2010 19:36:29 -0500
Received: from mail.thefacebook.com ([192.168.18.105])
	by pp02.snc1.tfbnw.net (8.14.3/8.14.3) with ESMTP id o240ZlLR001202
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Wed, 3 Mar 2010 16:35:47 -0800
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.2.213.0; Wed, 3 Mar
 2010 16:36:15 -0800
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1Nmz31-00027V-PV; Wed, 03 Mar 2010 16:36:15 -0800
Content-Disposition: inline
In-Reply-To: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166
 definitions=2010-03-03_14:2010-02-06,2010-03-03,2010-03-03 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141493>

On Wed, Mar 03, 2010 at 04:02:20PM -0800, Junio C Hamano wrote:
> 
> * as/maint-expire (2010-02-26) 2 commits
>   (merged to 'next' on 2010-03-02 at 4015ae4)
>  + reflog: honor gc.reflogexpire=never
>  + prune: honor --expire=never

I take it you didn't like the refactoring of the parsing code?  I
agree that it is a decent sized change for relatively little added
value, although it does seem nice to make the option handling
consistent.  I was also unsure if the expiration-date handling was
common enough that it was worth putting in date.c and config.c, but I
didn't really see a better place.

Feel free to let me know if you had any specific complaints about it,
or if you think it could be done in another way that so that it would
be worth including.

-- 
Adam Simpkins
simpkins@facebook.com
