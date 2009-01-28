From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 01:58:44 +0100
Message-ID: <200901280158.44386.jnareb@gmail.com>
References: <1233062946-22395-1-git-send-email-giuseppe.bilotta@gmail.com> <cb7bb73a0901271643g7c3a8c42qff6025187ab3c081@mail.gmail.com> <200901280155.26399.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:00:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRymp-0003hg-Ao
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbZA1A6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 19:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbZA1A6q
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 19:58:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:17491 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbZA1A6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 19:58:45 -0500
Received: by fg-out-1718.google.com with SMTP id 13so347282fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 16:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9qkfw8gExxdjkkVp/4vVzzQ32/3PiJDF4i5+MEoaJbk=;
        b=qwt7IkJ57VyG5PiQCO7MhShir/x13s9noHvsfvMKDX8Os/5hpOS4tafU7jkfowOLUl
         9fO2nMPRpVUmi3oTSIOL7tkquGVBGEU7RTpouPFzuZTXygkdlt0AOltf+yaHho2enW3e
         oIPy6PKqwnBvm64ufuFOGsL6od1cN/NT/lKb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rgMeRLd3LUMRu4eprFFHLS/jqGNx/XZLxF4ZtbEhVMhFkk2Nflh2xSFCd4lAlkZKF2
         1pOfHXbbeiCheEJ//wJ749I3LPByVxD+4D03wUI7awtxGNSiZRAWws+KhRFbIiau1D8R
         spJQmv8n0PiUuTKjZ8nYxhCQQGUKEJr9zKhfo=
Received: by 10.86.25.17 with SMTP id 17mr515626fgy.39.1233104323790;
        Tue, 27 Jan 2009 16:58:43 -0800 (PST)
Received: from ?192.168.1.15? (abvq8.neoplus.adsl.tpnet.pl [83.8.214.8])
        by mx.google.com with ESMTPS id e11sm4486932fga.29.2009.01.27.16.58.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 16:58:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200901280155.26399.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107438>

Jakub Narebski wrote:
> On Wed, 28 Jan 2009, Giuseppe Bilotta wrote:
> > On Wed, Jan 28, 2009 at 1:14 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> > > On Tue, 27 Jan 2009, Giuseppe Bilotta wrote:
> 
> > > > Of course, last time I forgot that the BASE href is supposed to be
> > > > absolute. While Opera apparently has no problem with it being relative,
> > > > other browsers such as Firefox are stricter about it.
> > >
> > > Errrr... I think you are talking about _full_ vs. _absolute_, not
> > > _absolute_ vs. _relative_, see below.
> > 
> > No, I actually mean absolute vs relative in the URI sense, not in the
> > Perl/CGI sense.
> > 
> > http://www.example.com/ is absolute, / is relative
> 
> No, "/" is not relative, it is absolute, because it begins with '/'.

Ooops, sorry, I mistook absolute _path_ for absolute _URL_. 
Nevertheless path beginning with "/" inherits only net_loc (host).

-- 
Jakub Narebski
Poland
