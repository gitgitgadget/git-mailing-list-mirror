From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log --stat FILE
Date: Sun, 8 Aug 2010 14:26:21 +0200
Message-ID: <201008081426.21705.jnareb@gmail.com>
References: <yf9wrs1fili.fsf@chiyo.mc.pp.se> <AANLkTikKwp9gS9nt=JnsdyXMgx+PxrhHhNFftYFqX+M_@mail.gmail.com> <yf9d3tts438.fsf@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Sun Aug 08 14:26:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oi4ww-0004ra-21
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 14:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab0HHMZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 08:25:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36002 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab0HHMZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 08:25:52 -0400
Received: by fxm14 with SMTP id 14so4561759fxm.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ErVGmwb0YaT4ddRAhx3rx3XBdM7JMisLX6OvQLoGijY=;
        b=YuDfIw3jn/k56A/xHjzGEotoJ0uFzSrey7Zcjap8VaK/e3cfP3XaM3xy8KisPZWTH5
         jbwd9SB9La/bTpN9Ne52uP1RhKtVc+fgMa5KvR7L/X7J8Z7uPiL7C1SbuZmuzEl4oQX3
         FMT3DsgOEj0Ktqjv8OB8W+8st0Fo+wTFghoLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Jq/qbJM35gXReQLHavd5zmcyx76w/Wz3Bdk9tHe58m9eeveYTkUoiP9f2hUtwO2cjt
         mWznYzRio5yDaIy1e0PT8+i8z7GUXlbR/OpxsWQMKkZ3eF4AEdyZdWnaJpftNQVROKvn
         jRrenZZD5XdEWT1Muwr/gdrtsb4JTUUNL0DJk=
Received: by 10.223.119.147 with SMTP id z19mr15278869faq.64.1281270351702;
        Sun, 08 Aug 2010 05:25:51 -0700 (PDT)
Received: from [192.168.1.13] (abwa128.neoplus.adsl.tpnet.pl [83.8.224.128])
        by mx.google.com with ESMTPS id l19sm1412295fap.33.2010.08.08.05.25.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 05:25:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <yf9d3tts438.fsf@chiyo.mc.pp.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152903>

On Sun, 8 Aug 2010, Marcus Comstedt wrote:
> 
> Thanks guys.
> 
> I suspected there was some option I had missed.  :-)
> 
> Both the option name and the documentaion mention only diffs, not
> stats, which makes it a bit hard to find...

Diffstat is just a diff format (a way of presenting diff); '--stat'
is described in "Common _diff_ options" of git-log(1) manpage.

But whats obvoud to me might not be obvious to everyone.
-- 
Jakub Narebski
Poland
