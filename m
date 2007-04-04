From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: A few minor fixes to Git User's Manual
Date: Wed, 4 Apr 2007 17:22:58 +0200
Message-ID: <200704041722.58780.jnareb@gmail.com>
References: <11756176481314-git-send-email-jnareb@gmail.com> <20070403172113.GB26201@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 01:15:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZEhQ-0003Sf-I0
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 01:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbXDDXOg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 19:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbXDDXOg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 19:14:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:30891 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbXDDXOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 19:14:33 -0400
Received: by ug-out-1314.google.com with SMTP id 44so836577uga
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 16:14:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C7D/lKmAd8cK6UOvosw+3ktyULfWwRL+rB3jGSmqXTHKN9c4T73XdrUxJH/kAsMb3HDtTbazHCrfF7FmzTB4S2blW0RyYk7FLH2xFtZgmmRowX/f41SmB8deAmokJHZHs2cYXHHyxe4bwA3PBjdzGktUmFktFKDYEfORwuKh3KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gD2433oOpLvTlMRDkG7kREoO01POrIWfTW+m1h9DcxVN4BBKB2ZoW8drPSIb2yW5qKASjXDbLbTsblgJ7KElvXoj/tAwuR6PA1OinBlSQIGcQUz7faPEfD2R1MSPlw4TVHkL/BwjMoaokKkvgxprouduJwM6gr+oMvSAYVUM0XQ=
Received: by 10.67.102.16 with SMTP id e16mr472824ugm.1175728468037;
        Wed, 04 Apr 2007 16:14:28 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w5sm2670402mue.2007.04.04.16.14.26;
        Wed, 04 Apr 2007 16:14:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070403172113.GB26201@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43788>

On Tue, Apr 03, 2007, J. Bruce Fields wrote:
> On Tue, Apr 03, 2007 at 06:27:28PM +0200, Jakub Narebski wrote:
>>
>> A few [shorthand] comments about Git User's Manual:
[...]
>> * inconsistent use of header levels
>>         Level 0 (top level):     ======================
>>         Level 1:                 ----------------------
>>         Level 2:                 ~~~~~~~~~~~~~~~~~~~~~~
>>         Level 3:                 ^^^^^^^^^^^^^^^^^^^^^^
>>         Level 4 (bottom level):  ++++++++++++++++++++++
> 
> Have you found internal inconsistencies, or are you just referring to
> the fact that it's using different syntax from the default?

Both, but more the fact that I haven't noticed that user-manual uses
different syntax (____ and not ==== is Level 0), and that I mistook
____ for ---- (perhaps #### would be better, if it is possible), but
also the fact that parts Git User's Manual is composed of use different
sectioning.

> I'd kinda like to remove all the tutorials some day and absorb them into
> the manual instead, but maybe that would be unpopular.

I'd rather keep the tutorials, perhaps making them more tutorial-ish,
and adding proposed but not as a patch and not included "Branching and
Merging" tutorial, and making Git User's Manual more a reference material.

-- 
Jakub Narebski
Poland
