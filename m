From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Wed, 9 May 2007 09:44:13 -0700
Message-ID: <56b7f5510705090944m6605fb82pa79a1623d8084dcd@mail.gmail.com>
References: <4640FBDE.1000609@gmail.com> <20070509135602.GB21489@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 09 18:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlpH2-0005pb-53
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707AbXEIQoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755687AbXEIQoP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:44:15 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:55623 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbXEIQoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:44:14 -0400
Received: by nz-out-0506.google.com with SMTP id o1so260034nzf
        for <git@vger.kernel.org>; Wed, 09 May 2007 09:44:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mWDl+ppodzLGphtReJMB0ByMa/sq3ycYAKN+schmVLPtSuk6azHIGMEDXLD1ytJTXdmyRI6mGpCx8Oh2Nl5KQpwE1198RajnEJkzg3CNpR2zwEQYhIHti5n5RXbmDdd1PDAHvPwTnnoFjIPA5tr9OEHEPT7qyCbD8flxvpUdU20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gsqg9LgKSCjwWox2vWGopo8zk4mS9Cc7KXfYaddZjYvh33VB+V/XSBSZZLqJ+7io8WIg5EW59a6pEcY2xKamatLdpQvB5iYCC9xcZ1T26A+cB2Dh5cq070w1CoNoIrp0BRevW94MGh5286uU5N2J6iyiwbrcw/4aiVjNQoru1NM=
Received: by 10.115.17.1 with SMTP id u1mr233263wai.1178729053543;
        Wed, 09 May 2007 09:44:13 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Wed, 9 May 2007 09:44:13 -0700 (PDT)
In-Reply-To: <20070509135602.GB21489@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46748>

On 5/9/07, Theodore Tso <tytso@mit.edu> wrote:
> I noticed that the patch didn't include additions to
> Documentation/config.txt; could those be added, so that as much as
> possible all of the various configuration knobs are documented in one
> place, please?

I will update the documentation,  after we've stopped changing
the set of options and behaviors.

You can see that's just what I did in the max-pack-size patch.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
