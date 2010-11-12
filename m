From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: scan entire repo for changes to file
Date: Thu, 11 Nov 2010 19:44:34 -0600
Message-ID: <20101112014434.GA10679@burratino>
References: <ibi59v$pjg$1@dough.gmane.org>
 <AANLkTi=uKhrvAS6ApnmCZnfbFboYU77rNcKDpaSBn1id@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 02:45:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGihU-00044T-Bb
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 02:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab0KLBpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 20:45:03 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42446 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab0KLBpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 20:45:01 -0500
Received: by qwi4 with SMTP id 4so519903qwi.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 17:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hxB56e4qtotd5bHCSaRa2/Vos27fGA8A1KdXMfnLRzw=;
        b=lvZMF01XzJi9dp6f8wuXcJEzey52FE9s7m+KqUtxDU3nqZrErFJ20/JZZdXCSI5xuW
         20B9/iaccotjcMHFHCupQKeGq9yWnvOmqpQ0mMkGrjMWRme8atsCccVvWGya0ANOo64b
         iz92n5gJn9qpfPRzcnqtE4BGJQatb5eoncmkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KFr5T0wAZBmc/MUSqRvkrxpSypM4oKTv8GbDdjq/RNXK7AcxM458SNp7Rm/9MuI4Yy
         qNCabK6yW7aCOfd5edzDXr2V5nJQZ2gVz5xOYOTdKk2hJe4hHL0qwOW/wOK7/koH1z9U
         cphITtMFQAN/NkehrSr6FZjcTnNphwtga+4FA=
Received: by 10.229.215.193 with SMTP id hf1mr1408704qcb.59.1289526300132;
        Thu, 11 Nov 2010 17:45:00 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm2528536qck.13.2010.11.11.17.44.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 17:44:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=uKhrvAS6ApnmCZnfbFboYU77rNcKDpaSBn1id@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161315>

Martin von Zweigbergk wrote:
> On Thu, Nov 11, 2010 at 8:28 PM, Neal Kreitzinger <neal@rsss.com> wrote:

>> Is there a way to scan my entire repo (many unmerged branches) for any
>> changes to a file?
>> e.g.
>> $ git log * -- somepath/myblob
>> would return all commits in the repo that changed myblob.
>
> Might replacing '*' by '--all' give you what are looking for?

Probably with --full-history if you want to know what happened on
historic branches, too.
