From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Makefile: create an install-symlinks target
Date: Wed, 18 Jul 2007 15:08:14 +0200
Message-ID: <81b0412b0707180608j7c22631ak87f3ddd6481bccf2@mail.gmail.com>
References: <86bqe9lwy8.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 15:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB9GO-0003vk-K3
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 15:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbXGRNIR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 09:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbXGRNIR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 09:08:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:14814 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbXGRNIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 09:08:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so253741ugf
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 06:08:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OsjZzkB8zbBRjZV61mHdKEGwHv1ZOuX+7z+9hUCQMA3lW0EBlOYcX/+go1RHUPDJKIOmIUf4BOLuUv1S8O7y/Hcwa1UpyllXTMVXrzz5KBt/dPqyey6mrzVzBDkP7O2ucSECRGBaXrPGx1DfpFt6pJdG7vG/+zIr0LdYs5NzqeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eT/8j247FCjO7Pt2n9EUk2ENnCAcktRf+cJXrmf3sqllSmyDC+SNuH8m5LAyeFq0PL/eEtYeYzCXrH+BQyCX4v8A716bkkU5d2E7CeR7DMQ54typlu+lmJrWYhSpBj/SchpBnZd2uQ3szSxy768yl8GYUpTnbscn3ozh3zDZ5fk=
Received: by 10.78.180.18 with SMTP id c18mr444085huf.1184764094548;
        Wed, 18 Jul 2007 06:08:14 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Wed, 18 Jul 2007 06:08:14 -0700 (PDT)
In-Reply-To: <86bqe9lwy8.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52860>

On 7/18/07, David Kastrup <dak@gnu.org> wrote:
> +       @: $(MAKE) && cd '$(prefix_SQ)' && find . -mindepth 1 ...

Sometime about now you'll need to define $(FIND) or even $(GNUFIND)
for find. There are proprietary systems where find is not available or
does not do what you want it to. There is often a gfind installed somewhere
on these systems.
