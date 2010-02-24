From: "ddrowley3@juno.com" <ddrowley3@juno.com>
Subject: Re: git-push segfault
Date: Wed, 24 Feb 2010 16:27:28 GMT
Message-ID: <20100224.082728.16634.0@webmail17.dca.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Wed Feb 24 17:36:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkKDR-0008D6-01
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 17:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308Ab0BXQfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 11:35:55 -0500
Received: from outbound-mail.dca.untd.com ([64.136.47.15]:45442 "HELO
	outbound-mail.dca.untd.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757300Ab0BXQfy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 11:35:54 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2010 11:35:54 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juno.com; s=alpha;
	t=1267029353; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; l=0;
	h=From:Date:To:Cc:Subject:Message-Id:Content-Type;
	b=otUqslcs/UK8HFB3or+A7jLIDe8P/ZCJxMnhf89hkS0yOUk5dv0ySmhOAslhF3kUs
	 aliG05whXEl3JjHOrPw+Hifa649lQg41TzAqW3o1YHGqN3hUr0a18Bss886nZhZ8Ja
	 EBODsaphjooxKu9Kfrqd+49EjWGC2JpgzjkoLRjU=
X-UOL-TAGLINE: true
Received: from outbound-bu1.dca.untd.com (webmail17.dca.untd.com [10.171.12.157])
	by smtpout02.dca.untd.com with SMTP id AABF2LW68ANNTQSA
	for <git@vger.kernel.org> (sender <ddrowley3@juno.com>);
	Wed, 24 Feb 2010 08:28:14 -0800 (PST)
X-UNTD-OriginStamp: de49jOYwx4VJX2uFLnkXWKJ0dUN5HbligOY16zusGMDICW/AhL1isA==
Received: (from ddrowley3@juno.com) 
 by webmail17.dca.untd.com (jqueuemail) id P7J3XQ2S; Wed, 24 Feb 2010 08:27:44 PST
Received: from [71.212.187.72] by webmail17.dca.untd.com with HTTP:
	Wed, 24 Feb 2010 16:27:28 GMT
X-Originating-IP: [71.212.187.72]
X-Mailer: Webmail Version 4.0
Content-Disposition: inline
X-UNTD-BodySize: 692
X-ContentStamp: 3:5:472173826
X-MAIL-INFO: 058afa9e23ce2f03bb2b7f
X-UNTD-Peer-Info: 10.171.12.157|webmail17.dca.untd.com|outbound-bu1.dca.untd.com|ddrowley3@juno.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140953>


> Does that trigger the problem for you? If not, can you show what is
> different between your earlier reproduction recipe and this one?

Yes, same problem. Here's the output:

Initialized empty Git repository in /tmp/parent/.git/
Initialized empty Git repository in /tmp/child/.git/
warning: You appear to have cloned an empty repository.
./test.sh: line 12:  3686 Segmentation fault      (core dumped) git push

I reproduced this consistently on 2 different machines with 2 different versions of git, so it must have something to do with my ~/.gitconfig. Yep - if I remove the following from my .gitconfig, then the seg fault goes away:

[push]
    default = tracking


Dale


____________________________________________________________
Criminal Lawyer
Criminal Lawyers - Click here.
http://thirdpartyoffers.juno.com/TGL2131/c?cp=NyvAFq3GMltQMHm1-EJV8wAAJz1C6gppc1sGnWt7Fqwc41TnAAYAAAAAAAAAAAAAAAAAAADNAAAAAAAAAAAAAAAAAAAiFgAAAAA=
