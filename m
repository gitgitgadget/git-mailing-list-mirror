From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 0/2] Fix issues with series deletion
Date: Tue, 12 Jun 2007 23:16:03 +0100
Message-ID: <b0943d9e0706121516k77709f3u8361a818f14a318e@mail.gmail.com>
References: <20070606205852.7657.69286.stgit@gandelf.nowhere.earth>
	 <b0943d9e0706071450u1587d109x1e592bfa453c0c0@mail.gmail.com>
	 <20070609184317.GM6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 00:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyEeo-00043k-Db
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 00:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbXFLWQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 18:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752875AbXFLWQG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 18:16:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59674 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbXFLWQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 18:16:05 -0400
Received: by ug-out-1314.google.com with SMTP id j3so273986ugf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 15:16:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z15wpskutnhw7RpHg95OdY1XQindkW5D6A1VciJD2zmqtFkAxcByLJl3kEX5Q8qTU9BJ2xvAKx+B09yrmS+9M7bcpfQJowyrdrt/1I43+oOehXAT8JLDn6O9qByHcGJ/Y3qQrdqwu5a+F2rAAwlfBp7EfNGYK45hqDAsutDumfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MS5oOClv1XY7bIjsFe5VuuM2jue7Uu/oVilKHzbUqpVVSCs+leqtORK9QL82ZMT/Ds+53vhE9EyPzJGOPJbMo0G3q1C1k12WDLYSw72MGgnTKwLuURLtf8mvpV+2XMktGxaSvbM2nfqWFaeEea/At2PboMDaRk30oqucDEj/Omg=
Received: by 10.66.240.12 with SMTP id n12mr792964ugh.1181686563515;
        Tue, 12 Jun 2007 15:16:03 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Tue, 12 Jun 2007 15:16:03 -0700 (PDT)
In-Reply-To: <20070609184317.GM6992@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50006>

On 09/06/07, Yann Dirson <ydirson@altern.org> wrote:
> Speaking of transactions, did you have a chance to read the proposal I
> posted some time ago ?  As stated in another mail, I fear that
> approach does generalize easily to core git - but for lack of a better
> solution, we may want to go this way anyway...

Yes, I managed to read most of it at that time. I'll try to reply to
the individual points in that e-mail. My idea was to store all the
stack state, including patch information, in a single file rather than
having them scattered around (maybe XML, sounds cool :-) but it's not
easily parseable from shell-scripts).

-- 
Catalin
