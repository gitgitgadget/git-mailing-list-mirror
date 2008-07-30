From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: Gitweb: Provide Git links in project list?
Date: Wed, 30 Jul 2008 16:55:40 +0200
Message-ID: <36ca99e90807300755r1b1bc53bmdbaa1811370cd1f@mail.gmail.com>
References: <20080730125743.GY15356@erda.amd.com>
	 <20080730130257.GB28566@frsk.net>
	 <20080730131357.GZ15356@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Fredrik Skolmli" <fredrik@frsk.net>, git@vger.kernel.org
To: "Robert Richter" <robert.richter@amd.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 16:56:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOD6X-0007Dy-9d
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 16:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbYG3Ozm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 10:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYG3Ozm
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 10:55:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:51862 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762310AbYG3Ozl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 10:55:41 -0400
Received: by rv-out-0506.google.com with SMTP id k40so52699rvb.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QoiMxq9A/IvYlhgS6LHEXX/0oWm8Ya+LzN0Y4Rrrl/k=;
        b=rf1KCyLddMOPRKSngnPNbo7L/JQ9KaHChgeR4ZkLLIWeMi99TDQrZZqa4mT01sSzUw
         cMXx0+Sz70CZN9eGLMwctSay2NTcktv6+hMaTEBEW+oI9uKZoMT713BnhOKx0U03TxCP
         zqyhjwcd5hsLa0tSZshT4RSirgOLo8g5yWvnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vGG5KRavnmNLEg37IPqLl7FNKnf36WV96skhzkwZndmdi+IWkFJdXZcVga6czP8Xh9
         3O/S14Odo28hwrv7TvZySPKhOOIN6swb3z0ifTycif3XlPpKadQIzUMz+MVVo0MSOyhP
         ev/VtqN6uwhwm/HopyTrsYEKOBKEVtbgn81Q0=
Received: by 10.141.211.13 with SMTP id n13mr4366213rvq.184.1217429740522;
        Wed, 30 Jul 2008 07:55:40 -0700 (PDT)
Received: by 10.70.20.12 with HTTP; Wed, 30 Jul 2008 07:55:40 -0700 (PDT)
In-Reply-To: <20080730131357.GZ15356@erda.amd.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90798>

On Wed, Jul 30, 2008 at 15:13, Robert Richter <robert.richter@amd.com> wrote:
> On 30.07.08 15:02:57, Fredrik Skolmli wrote:
>> On Wed, Jul 30, 2008 at 02:57:43PM +0200, Robert Richter wrote:
>>
>> > The Gitweb on git.kernel.org povides links to the Git repository for
>> > each project (git <git://...>). However, I did not find this feature
>> > in the current implementation of git_project_list_body(). Does
>> > somebody know if there is a patch available for this and if this could
>> > be added to gitweb?
>>
>> Is putting the address in .git/cloneurl giving the behaviour you're looking for?
>
> Yes, I did change this and in the project summary I get "URL git://...".
>
> That I mean is the main page, that lists the projects. I only have:
>
> ... summary | shortlog | log | tree
>
> At git.kernel.org there is additional '... | git' with a link to the
> Git repository.
>
> The current source of gitweb seems not to provide this.

Look here for all notible forks of gitweb:

  http://git.or.cz/gitwiki/Gitweb

Bert
>
> -Robert
>
> --
> Advanced Micro Devices, Inc.
> Operating System Research Center
> email: robert.richter@amd.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
