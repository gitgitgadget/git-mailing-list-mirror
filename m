From: Leo Razoumov <slonik.az@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Tue, 29 Sep 2009 14:44:40 -0400
Message-ID: <ee2a733e0909291144g4b99ab7ay9e63bfac935013aa@mail.gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org> <m33a66br69.fsf@localhost.localdomain>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anteru <newsgroups@catchall.shelter13.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 20:46:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mshgt-0008KU-Nv
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 20:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbZI2Soi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 14:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZI2Soi
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 14:44:38 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:62121 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbZI2Soi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 14:44:38 -0400
Received: by ey-out-2122.google.com with SMTP id 4so339957eyf.19
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=GoL5l2BxuUtnchUJM0aSDHvbhhwTFsfiO8H68ThVmfQ=;
        b=gbV+16a2hi0HWBEQn7c14JS5UyaW5uq2JQ88oQx2mLNOjgOmqCAf+DRhK5zbZGfthc
         EijrJVpczLZRgjXt9T+ayCP30Ot1VR3+lG3SOGHnDqk54j86At5LEGBycD9xbUNW6U8w
         kQsUJ/ytI/0Kr9xTPBXD9G/QyIIODgua3kEGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=oTyVnefW+GhXNmTvMn0fEDO4QzR3xrd6AQe2bwP6Xu1JOgqrfTXSNKMSW+YKYU4RSB
         pbArNqSO4+POOOCjXL7iI2sJvrAVx1G7xakPjQoS5/ZPEJtDGi5VipT0NwbDwNx76akp
         zWo/wlIZS39/nyOAN1RKOfIVLw07amBad9JDo=
Received: by 10.216.71.133 with SMTP id r5mr1179507wed.180.1254249880807; Tue, 
	29 Sep 2009 11:44:40 -0700 (PDT)
In-Reply-To: <m33a66br69.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129322>

On 2009-09-28, Jakub Narebski <jnareb@gmail.com> wrote:
> [..snip..]
>  Besides with nonlinear history with
>  revision numbers such as 12678 and 12687 you know that 12678 is older
>  than 12687 if and only if 12678 and 12687 are on the same line of
>  development.
>

The statement above is incorrect!! In a Mercurial repo local revision
numbers are strictly ordered in commit time. 12678 < 12687 means that
12678 was committed prior to 12687. But these two commits could belong
to two completely unrelated lines of development.

--Leo--
