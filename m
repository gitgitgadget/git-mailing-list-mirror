From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 19:58:52 +0200
Message-ID: <48C80ADC.60207@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910164045.GL10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Theodore Tso <tytso@MIT.EDU>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 10 20:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdTz4-0002Qu-HA
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 20:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbYIJR67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 13:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbYIJR67
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 13:58:59 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:22435 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYIJR66 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 13:58:58 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1106158rnd.17
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=EqUXBhZa2P1cw1TgJAGdnP1ivNak9ma5aaLxo4dSp7c=;
        b=JDFPpAZnQNcGWJZRz77mbconJ+vcJiPpYrdZs1JCnPUUNkuU7107/8ARYXmSOX6M7P
         lHjpXRytkMaCxvVXz36Bh2XrBFBv63crdPeXBn44H51xRqmNwgTSH2S7BnEJhGcEJnmi
         DQuOOnWFrMxZ2oSyuMqk815wpQYGri/uBgdbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=SOM7YQqnx345Dl5APnNz1YSvVT4K13kQIk6ar6iTb+bJVIAP3EETOYo2AfwnRia7FL
         GjsyirVUPkxbIJnwhRI5hqoYQjprDzbmNKNf/4ve5+NALG/s1+sPMjcNMT+DBXaYbCrz
         QZZ5kvulquh7GMXW6E7fqKeauuZUuZZx8aYVE=
Received: by 10.86.29.8 with SMTP id c8mr1215764fgc.30.1221069535416;
        Wed, 10 Sep 2008 10:58:55 -0700 (PDT)
Received: from scientist-2.lan ( [89.96.108.150])
        by mx.google.com with ESMTPS id l19sm7795654fgb.7.2008.09.10.10.58.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 10:58:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080910164045.GL10360@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95543>


> I'm not endorsing assigning UUIDs to commits now at all (but I don't
> have time to formulate a comprehensive argument against that either).
> 
> However, having a commit -> nonessential_volatile_metadata database
> would be useful for many other things as well!

100 points to Petr. :-)

Paolo
