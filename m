From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] Add default merge options for all branches
Date: Tue, 3 May 2011 23:58:03 -0500
Message-ID: <20110504045802.GF8187@elie>
References: <20110503090351.GA27862@elie>
 <4DC0608F.9040208@dailyvoid.com>
 <20110503204442.GI1019@elie>
 <7vsjsvgzzf.fsf@alter.siamese.dyndns.org>
 <7vzkn3f5wo.fsf@alter.siamese.dyndns.org>
 <4DC0D605.20204@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	vmiklos@frugalware.org
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Wed May 04 06:58:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHUAA-0008Le-A7
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 06:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab1EDE6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 00:58:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50438 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab1EDE6I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 00:58:08 -0400
Received: by iwn34 with SMTP id 34so663803iwn.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 21:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0jHyvculBgA6el8vKCnrewnr1p07U0sll6T0wpCqxEA=;
        b=SynwLQ9Or86f3CRftARxTcbImmBbKa23waG5N4UBzEXjeAkHppX9c2EZ4H3JNt3PB9
         9RcHWDBbC3Ywyg3lV/1V1gOovlyId9ainllJlS7CTeTzwPuVQ4GcKrCrDsuh5D+SmxAV
         Ug8BfKWlKeiAMzunzfzalzFfW55WtDxfVqo/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hQtXcmmn0f/dd8Awkj1t/HiTo3pY8Jo123ynIMDJqBD7xJTJlc3y4bafUUjM55lvG9
         6tGCJAg12gVQizdMwTzQCY5iDQus5bWXybw5JKLigUBoGkMa7/COSDhWGry+bMwstJ5w
         Tiw3Hm0t1FJvUdtcLrtXQbMOqAqY2TfQg7clk=
Received: by 10.43.54.193 with SMTP id vv1mr1155901icb.338.1304485087275;
        Tue, 03 May 2011 21:58:07 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id jv9sm294748icb.1.2011.05.03.21.58.05
        (version=SSLv3 cipher=OTHER);
        Tue, 03 May 2011 21:58:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DC0D605.20204@dailyvoid.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172715>

Michael Grubb wrote:

> I take this to mean that my patch is no longer needed/wanted?

No, as usual it means that Junio was thinking and sent us his
thoughts.

Do you like it?  If so, the way to move it forward would be to add
tests and write a commit log message.  If not, the way to move things
forward would be to explain what use case it misses and work on a
better patch that takes care of them.

Hope that helps,
Jonathan
