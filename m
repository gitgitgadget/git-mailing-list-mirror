From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] git-grep: add --color to highlight matches
Date: Mon, 26 May 2008 18:07:37 +0700
Message-ID: <fcaeb9bf0805260407r6a1bea23v3861d3c43df01939@mail.gmail.com>
References: <20080524043118.GA23118@laptop>
	 <m3ve142jkc.fsf@localhost.localdomain>
	 <fcaeb9bf0805240220x78943f8ap67344a508531faa0@mail.gmail.com>
	 <200805241259.13132.jnareb@gmail.com> <483A7B1F.1050608@op5.se>
	 <alpine.DEB.1.00.0805261113050.30431@racer>
	 <fcaeb9bf0805260357t2bce7753vab5331bb21d98e4b@mail.gmail.com>
	 <alpine.DEB.1.00.0805261200330.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 26 13:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0aZU-0004eH-FC
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 13:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbYEZLHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 07:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbYEZLHk
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 07:07:40 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:12093 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbYEZLHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 07:07:39 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1442682mue.1
        for <git@vger.kernel.org>; Mon, 26 May 2008 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OD96FjZU/11bi0Z7cMKy0/1mk8w1QOB46U36rdwsFrw=;
        b=f1ZhzwIcNwB/cubbqY62HXAtyMqwaeOMENqh0sb0HHUBwhrVUu0nMmbbLniXZcCeq0Z+Ud1TIPEboy6qNT+uzZFa6bhBjjsxYinRna198F8hdsyrOb/H/9UFQEGOhckkKdVMN0tNeYCHkc/j3YQ9/fTN/qjHzDQ791BKDNZtQ1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p2uqBZBcT7Z/00LJK9Ma3l7AOOthvveDOp9Dmb8HEYX5qxvsrwcol3dbLriE1niUVRjZW06e6fZP8nIViy1vYNMOqa2N9dbehlaegIYJkympaSrMEC+zE5TQfb3A6d+yc0bi7Gwaq5S87InSjt/9llm+Pd/j273wMP9+7R1wPbA=
Received: by 10.86.77.5 with SMTP id z5mr1310782fga.35.1211800057607;
        Mon, 26 May 2008 04:07:37 -0700 (PDT)
Received: by 10.86.62.13 with HTTP; Mon, 26 May 2008 04:07:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805261200330.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82920>

On Mon, May 26, 2008 at 6:00 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 26 May 2008, Nguyen Thai Ngoc Duy wrote:
>
>> On Mon, May 26, 2008 at 5:16 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Besides, it would be a kludge at best to work _twice_ to find out the
>> > search terms, once in the external grep, and a second time in the coloring
>> > code.  So I think it should not be done.
>>
>> I think if it's GNU grep, just passing it --color, it will grep and
>> colorize search terms in one turn.
>
> And what tells you that the called grep is GNU grep?

A newly added macro like HAS_GNU_GREP? Granted it won't work all the
time. The user who set the macro should know what he is doing. This
approach is IMHO fine as long as we don't allow color customization.
-- 
Duy
