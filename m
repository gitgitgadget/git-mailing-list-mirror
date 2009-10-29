From: Rogan Dawes <rogan@dawes.za.net>
Subject: Re: date change of commit?
Date: Thu, 29 Oct 2009 16:47:03 +0200
Message-ID: <4AE9AAE7.2080404@dawes.za.net>
References: <e4a904790910250435p3ff50dcfv5c0c6a86c13d17b@mail.gmail.com>	 <vpq1vkrqttt.fsf@bauges.imag.fr>	 <e4a904790910270241g4a165023o30438c5d000b5de4@mail.gmail.com>	 <20091027122156.GD6115@genesis.frugalware.org> <e4a904790910290555n61bca296g3624c1aced50ed85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Alex K <spaceoutlet@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 15:47:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3WHj-000347-VT
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 15:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbZJ2OrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 10:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbZJ2OrS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 10:47:18 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:17191 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940AbZJ2OrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 10:47:16 -0400
Received: by gv-out-0910.google.com with SMTP id r4so280164gve.37
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=NPnxe3HfEPhOiV1Ix8Zf95I05clwkbeFmv3i9ezXo2U=;
        b=elKqm5c1ZLk4mNgPA78QMxcVHwwxL3X5tBfMOeSOUuE1MUJaKlB+yhyKwd1cOgA/bq
         c7m9Jh5/IOG5ODvZGYaGO6PnW1TjcNXvlBz8JP8bYfY9U662ojjvGqCvneC2nwwJi7Er
         0dpjs7MZOPOLqzrI9m/Yp+zpopjxyF3c18Roo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=eBwZC+/QZfR6is53VGaz2DIaJ7jbZfX457SM69hekB3AB/mlHN9XoUCH0xPjkKPoAy
         zAic8WoP7TGIKSUOgKjcakTH8pM1S++UzSut+7PLZydiUt3ncQAj8T8TSj5OYi5jpIO5
         sJsqiXjV51As2FOWobjcl7ctG9r5+QYqbtCNw=
Received: by 10.102.222.8 with SMTP id u8mr53060mug.96.1256827640590;
        Thu, 29 Oct 2009 07:47:20 -0700 (PDT)
Received: from artemis.local (dsl-246-22-143.telkomadsl.co.za [41.246.22.143])
        by mx.google.com with ESMTPS id j2sm7426172mue.16.2009.10.29.07.47.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 07:47:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
In-Reply-To: <e4a904790910290555n61bca296g3624c1aced50ed85@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131595>

Alex K wrote:
> And how do you actually set those variables? Sorry to ask such a
> trivial question but it's been an hour that i'm going through the doc
> for such a simple feature. I thought those were environment variables
> ... but they are not seen under git var -l. Thank you.
> 

As you suspected, they are environment variables.

i.e. :

$ GIT_AUTHOR_DATE="1112911993 -0700" git commit x

Hope that helps.

Rogan

> 2009/10/27 Miklos Vajna <vmiklos@frugalware.org>:
>> On Tue, Oct 27, 2009 at 10:41:47AM +0100, Alex K <spaceoutlet@gmail.com> wrote:
>>> Thank you. And how would you use git-filter-branch to create another
>>> branch with a different time stamp? Is it possible to commit under a
>>> different time stamp than the one provided by your default local time?
>> You can set GIT_AUTHOR_DATE and GIT_COMMITTER_DATE. Both expect a format
>> like: "1112911993 -0700" (unix timestamp + timezone info).
>>
