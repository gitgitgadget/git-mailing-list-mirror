From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: .git inside a .git: is it safe?
Date: Wed, 14 Mar 2007 16:02:26 +0100
Message-ID: <8b65902a0703140802t4d98bbfdj84e8c4523e852e8a@mail.gmail.com>
References: <8b65902a0703121456s56008088ra14452ef7f325cf3@mail.gmail.com>
	 <20070312221540.GA16545@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 16:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRV00-0001Dv-AF
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 16:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161306AbXCNPC2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 11:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbXCNPC2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 11:02:28 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:34001 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161306AbXCNPC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 11:02:27 -0400
Received: by an-out-0708.google.com with SMTP id b33so209462ana
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 08:02:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lv+VCS4XWQli/bTbskgX17yDmAK5MuUfcoJ0SRU/Kc7BEV4GP5BqJfwASUrU8+01eJjX/dFbbAJg7vKskXgGxl1zkWNV7YACFDekDrFKhIWMLlfS4QkhEIwDkXHACJICM8E+qsj6mKevA1VrjZkMZwEuV+nvbR/VC2mRnc4HBQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VBb5UW5EBtYmE8KZm6Yx12gl9zsiqR+m6a9mTHR4aXW4TPT4Btgm1CkvT+Tyb25V7B9MK19XrON5zIM+pkLfMjXdgRV61ROQ85xHDoAtCubCf9MwkBCFjw6PMybrSOvNenBWaAn+6W2XRJdP0bGgwrN5S8oP+kFVbexJgDXOnAI=
Received: by 10.100.141.13 with SMTP id o13mr1985187and.1173884546660;
        Wed, 14 Mar 2007 08:02:26 -0700 (PDT)
Received: by 10.100.135.16 with HTTP; Wed, 14 Mar 2007 08:02:26 -0700 (PDT)
In-Reply-To: <20070312221540.GA16545@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42210>

Thanks for your answers. It's really a cool feature for my needs.

On 3/12/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Yes, that's fine.  You just probably want an entry in the top level
> project (myproject) that says ignore the stuff under mainproject.
> That way "git add ." in myproject doesn't include files in
> mainproject by accident.

In fact, in my case, I think I will prefer to store the mainproject's
sources in both Git repo. By this way, I will be able to easily found
the version of mainproject's sources that are compatible with the rest
of myproject.

-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
