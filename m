From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: suggest name for OPML view
Date: Sat, 10 Jan 2009 20:45:56 +0100
Message-ID: <200901102045.57589.jnareb@gmail.com>
References: <1230900570-25324-1-git-send-email-giuseppe.bilotta@gmail.com> <200901101510.20918.jnareb@gmail.com> <cb7bb73a0901101115i541f0911o42f08fc47820fb82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 20:47:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLjnw-0002Ib-BP
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 20:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbZAJTqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 14:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbZAJTqH
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 14:46:07 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:13832 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbZAJTqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 14:46:05 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1215274eye.37
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 11:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=V28Xjo3XAts6YRwvhzEUzk7UQr5RK2yRFJSYWagnMDA=;
        b=DE73+dHnHles1YxTPAXTn8gos1eGHy2oiASlSgVWCNaLWFSTFdmL6UQsTAOJlB5hpn
         iwB4Wd+Y9ZCfJN4WA3OFs5LRqMXyOt4X7bMwc8VFh19fJif4eNO1eHkGx6w8OUD1CtiS
         e1QiD6aaNi6CYje4cfmX29XlCAoCk/1llYugY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PWNGMHMM7rnys/gDU337SkT3mlvc9NryTay3ivudzkBmEvV40MZwo3HzCI880JJoU7
         37bL3oOTd5mzIBZWU+H4zoI54EgSUFQo2Rg3wT4gSHIurB0QiPwiJs50IG6mkvY77VqT
         COcGb99nhCZKKzvWocGPQq7pppM0nhJsK66UA=
Received: by 10.210.38.5 with SMTP id l5mr9076204ebl.58.1231616763634;
        Sat, 10 Jan 2009 11:46:03 -0800 (PST)
Received: from ?192.168.1.11? (abve97.neoplus.adsl.tpnet.pl [83.8.202.97])
        by mx.google.com with ESMTPS id 23sm2686801eya.3.2009.01.10.11.46.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 11:46:02 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0901101115i541f0911o42f08fc47820fb82@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105140>

Giuseppe Bilotta wrote:
> On Sat, Jan 10, 2009 at 9:10 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Fri, 2 Jan 2009, Giuseppe Bilotta wrote:
>>
>>> Suggest opml.xml as name for OPML view by providing the appropriate
>>> header, consistently with similar usage in project_index view.
>>
>> It is not name for a view, but more of default filename when saving
>> it. While it is good idea to have consistency, I guess that while
>> 'project_index' view and other non-HTML views are meant to be
>> downloaded and saved (snapshots, patches, patchsets), OPML view
>> is meant to be used on-line, just like web feeds in RSS and Atom
>> formats which are non-HTML too but do not have Content-Disposition
>> header set.
> 
> OPML is used for import/export of RSS feed lists between aggregators
> (e.g. moving your reading list from knewsreader to google reader). As
> such, it can also be comfortable to save it to disk for import by some
> tools. IMO, of course. [...]

If it is used in such way, then I am all for it (and of course for
consistency with 'projects_index' view).

Acked-by: Jakub Narebski <jnareb@gmail.com>

-- 
Jakub Narebski
Poland
