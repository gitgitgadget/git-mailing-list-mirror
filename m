From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Fri, 13 Jun 2008 07:42:25 -0700
Message-ID: <48528751.8070601@gnu.org>
References: <20080607220101.GM31040@leksak.fem-net> <20080612002258.GC7200@leksak.fem-net> <7vabhr9qru.fsf@gitster.siamese.dyndns.org> <20080612170715.GC6848@leksak.fem-net> <4851FFE9.30108@gnu.org> <20080613121607.GC7925@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:43:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7AUs-0005uM-Kz
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbYFMOm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbYFMOm1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:42:27 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:60841 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbYFMOm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:42:26 -0400
Received: by py-out-1112.google.com with SMTP id p76so1834361pyb.10
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=1F9QDLpqbMyd219X4/X5Cz4PaGWzIUwBUkhcn4LYyPw=;
        b=CMkM06LKb7YOMATIBU90Vxmqzd0/ws/az3TpubbewtWimSXGTHfNI205DOEflAWiRy
         4GdRkKDEm6I9uq2vViNnzfCOCobci8AisNJRLSypcKC77KzXMFVCaAEjbGFdZKR3WjCS
         0a0OQPxcGojmf+0UI6JW9BZmwMGdcWiq5gRFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=nzteNj9GQlRxWMpzdlWtJdnbUqO/odLc8IVKHZphen6D8ZVcYJNHHOzbOjLoIKEzXi
         SuaDcMgVN4B2/gbAqvd1afcgUIecdxxKLQSR84EpdSwNVK/6oqjz12trP+JOHMXgIq1c
         6wIVbEZqNldNlOEFnDiNCsSxJiwjrRcK7/iDI=
Received: by 10.115.50.5 with SMTP id c5mr3170503wak.60.1213368145110;
        Fri, 13 Jun 2008 07:42:25 -0700 (PDT)
Received: from scientist-2.local ( [65.248.49.163])
        by mx.google.com with ESMTPS id y25sm4089505pod.8.2008.06.13.07.42.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 07:42:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080613121607.GC7925@leksak.fem-net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84884>


> Now?
> 1)  squash --up-to :5
> 2)  squash --from :5
> 3)  squash --after :5
> 
> (1) suggests the wrong direction...
> My English feeling says that (2) "squash from" is better than 
> (3) "squash after", but I'm not a native speaker ;-)

Yes, it would be squash "everything after" X.  --from sounds good enough.

Paolo
