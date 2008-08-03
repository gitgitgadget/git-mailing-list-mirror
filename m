From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Sun, 3 Aug 2008 15:14:09 +0200
Message-ID: <cb7bb73a0808030614v260dea2ek6757b7a22b13afa2@mail.gmail.com>
References: <1217691554-10407-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <20080803120350.GW32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Aug 03 15:15:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPdQZ-0003vL-9W
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 15:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbYHCNOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 09:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbYHCNOL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 09:14:11 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:28242 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794AbYHCNOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 09:14:10 -0400
Received: by yw-out-2324.google.com with SMTP id 9so965954ywe.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HCVkI9ApDzTbza6ZDS7U3Ldv1DJFOMr/TI3kbvtNhDw=;
        b=o/wRdn924ZNTDWpegQV2BM0igNwIwb1A2Jj42hqw4GCsPXSuJY/XAyfAfSMJeOrAkL
         WDRk2IpYkY4ehK6knaZ4tDrq7pYMPZ7O2ElPg+nkTz5E/wax3xekpywZ8WUh4+iimq9l
         RgGDz+GGGvQWYzdSUetWuR62myvZIaYeG2omQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XjNCt40pMWkJ9N3YJuFhk5HzwkWp78P+kQ7KxoaGz3JVzV0MRTjt3wZx4tU8+pFWQj
         YdeyrOsxwm8QDH7gM0YWQRMDPST3gcqaZ1WpVVCVJHl0+D4l5ypL0Edc1PtsGUvScGer
         1I4sjVfXXJuNAsurdGIdkK0LY9fs5ztqVCZrU=
Received: by 10.150.95.5 with SMTP id s5mr6512488ybb.246.1217769249421;
        Sun, 03 Aug 2008 06:14:09 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Sun, 3 Aug 2008 06:14:09 -0700 (PDT)
In-Reply-To: <20080803120350.GW32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91237>

On Sun, Aug 3, 2008 at 2:03 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Sat, Aug 02, 2008 at 05:39:14PM +0200, Giuseppe Bilotta wrote:
>> This patch turns ref markers for tags and heads into links to
>> shortlog/refname. Appropriate changes are made in the CSS to prevent ref
>> markers to be annoyingly blue and underlined.
>>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
> I think this is good idea in principle, but
>
>        (i) Why not do this for all the refs?
>
>        (ii) I think you should decide on the type of the action based
> on the object type of the ref; actually, any kind of object type can be
> ref'd, and for tags you would rather want tag view, etc. (The tag view
> actually sucks and should behave more like git show tag - i.e. append
> the appropriate view after the tag info - but that is different matter.)

Funny that. My original plan was to have a different action depending
on tag (I tried shortlog for tag and commitdiff for branch). And since
I I had no idea what kind of action to use for 'generic' refs, I left
them out. Then I had second thoughts and started using shortlog for
both heads and tags, and collapsed the code but still kept the generic
refs out of the way. So maybe we can use shortlog as default action
and single out tags (and whatever else we'll find to need a different
action)?



-- 
Giuseppe "Oblomov" Bilotta
