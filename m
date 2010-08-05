From: Jonathan Nieder <jrnieder@gmail.com>
Subject: mm/shortopt-detached
Date: Thu, 5 Aug 2010 06:41:32 -0500
Message-ID: <20100805114132.GO13779@burratino>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <vpqmxt14gjt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:43:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogyqq-0004Ce-G2
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933201Ab0HELnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:43:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54498 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933173Ab0HELm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:42:59 -0400
Received: by iwn33 with SMTP id 33so107354iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uQtAGL/zAW3XRIfUziwiJu7wyyN4orfKYgUUADC+PPw=;
        b=OHS4xZy2QhmeyDUD9C5QI/S8XEX1THK63j8s+PK71ySqd4ynZLD9aiRc17+ayfBbef
         UTb2EDBVDaiB+fjs7e+p5E0EyFpAXgE1LBt0/WfaXGxDFDojkvXQlpEjrhVL82ZQCuYU
         33HKoXrHOQoqA/lm+tEGRMxlBfOHfSatse6lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w+2uVV+07jVBvi9TEO6mdUMQFhXZ420kDn5BUK+SQ6QURFoZRSueskFVoiANMPJ+BF
         OVxVSEIJgUNQ8DAEpvLH2EU32ATOtN99jC6U0IAupo5+8iiXR6EiojDXgp9F9NVaoyiS
         jpaXNnDj7PehTCyPAG5kSQJlISrc4auvmrxm0=
Received: by 10.231.118.28 with SMTP id t28mr11693723ibq.131.1281008578893;
        Thu, 05 Aug 2010 04:42:58 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm68128ibh.10.2010.08.05.04.42.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:42:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqmxt14gjt.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152646>

Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
 
>> * mm/shortopt-detached (2010-07-30) 5 commits
>>  - log: parse detached option for --glob
>>  - log: parse detached options like git log --grep foo
>>  - diff: parse detached options --stat-width n, --stat-name-width n
>>  - diff: split off a function for --stat-* option parsing
>>  - diff: parse detached options like -S foo
[...]
> Here's a new one, with very minor revisions :
> 
> * diff_long_opt renamed to parse_long_opt
> 
> * Use the same wording as api-parse-options.txt : separate/sticked
>   forms (essentially in commit messages and comments).

Still looks good to me.  Thanks.
