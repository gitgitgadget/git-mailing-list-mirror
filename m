From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [ANN] mtn2git v0.1
Date: Sat, 13 Sep 2008 13:52:39 +0300
Message-ID: <94a0d4530809130352v5775be53sc14b354b8c1dae15@mail.gmail.com>
References: <94a0d4530809121559w5f644174j461ec61cb2327fd8@mail.gmail.com>
	 <m3d4j8nzy9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, monotone-devel@nongnu.org, devel@pidgin.im,
	openembedded-devel@openembedded.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 12:53:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeSlB-0002Lm-At
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 12:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbYIMKwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 06:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbYIMKwl
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 06:52:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:54764 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbYIMKwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 06:52:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1236054rvb.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 03:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZsO2JZekuvuhSac9wD5nkluAY2KJwpkD57FOsRRuVwY=;
        b=Zs6yassuNikF+CHBwd4Vl2g4+2A2ppkHJQBHc1s4/LCClnFGajauyW5ITjiH52ipCa
         rnb36BjOOG903Y0yoLQwNGEystsYNLPjxxL7HbObIKerBvHilu/Byh1/pj04VP+0TDPu
         quqN1dg6A1A5AgjNJrCs/PFvbFNVhdzOBZRgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Sk9DwZoB94qg0dWrwU2ZIVhuIXdXKKllPlEhsxk6O01EE+FwVafJLWxWDUoF706JQa
         VwoeHysG6W99Nj37qfQ0jlHt16Ka+o2o9/7OrOQeCnF6X7WJa0q4e55h26BJwxDxVUE6
         jUI36A6yx+YRiT7njGtFWvBMzyslRx09II/yI=
Received: by 10.140.201.8 with SMTP id y8mr3304415rvf.28.1221303159789;
        Sat, 13 Sep 2008 03:52:39 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Sat, 13 Sep 2008 03:52:39 -0700 (PDT)
In-Reply-To: <m3d4j8nzy9.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95797>

On Sat, Sep 13, 2008 at 12:45 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Felipe Contreras" <felipe.contreras@gmail.com> writes:
>
>> This is the result of various experiments I've been doing while trying
>> to import mtn repositories into git. I've looked into other mtn2git
>> scripts but none fitted my needs.
>
> mtn or mnt?

monotone = mtn

>> After some RFCs on git and monotone mailing lists it seems now that
>> the script is going in the right direction.
>
> When you feel this script to be ready, could you add it to the
> "Interaction with other Revision Control Systems" section on
>  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
> As far as I can see there ain't any Monotone to Git converter on this
> list.

Ok, done. I think it's ready if you can bare the slowness of the
'checkout' method. The only missing feature is tags, but should be
easy to implement.

-- 
Felipe Contreras
