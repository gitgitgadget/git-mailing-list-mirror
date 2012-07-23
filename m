From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] mergetool: support --tool-help option like difftool does
Date: Mon, 23 Jul 2012 22:14:33 +0200
Message-ID: <CAHGBnuMCsxmVN8fCSgazqKUwtJzJJxtrVxjKwCEEhZJ_U0cW9w@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFAE1.3070304@gmail.com>
	<7vr4s2mnir.fsf@alter.siamese.dyndns.org>
	<7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
	<500D9E5A.2000204@gmail.com>
	<500D9EDB.90603@gmail.com>
	<7vhasyl0gc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:14:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StP1e-0000NA-3E
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab2GWUOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:14:37 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42808 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab2GWUOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:14:36 -0400
Received: by vcbfk26 with SMTP id fk26so5162068vcb.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nkWioPgRyd1lzXRLia1UAmqWu/adYocVgMoUe3SGg5k=;
        b=vNnD2wNZuk01gA6oGJpKMKUDOW0EjZsvb1fyhgO/pRGi9WQSg9Tlk59Mkk7hL/pI9z
         59DrmpMO3ikbuTIZAKevRrdQZ/q4VY5W97PI2Aoh/g5uZdsA/fRgbqAwTokvlEbN29lY
         aHuHXLFyCAjN5KCfc1/nCBe9PzWvKQs/IgJmLBcfvFs2DiI/A56Pu4fcUecGQMQ5UrJm
         VOSaahky0vMNK2q3Cys+KBaIzKSUil5Qptk9AkXpfrv6AZc4DppIwz1q+/ecfk9tbfVS
         /rvpgI0TW1J4QU/xBdNY3qF1+koJxpKPnTI52dBeV8ayzLds3h/YOynvu2UDDaD3zRwJ
         eC5w==
Received: by 10.220.39.206 with SMTP id h14mr13670881vce.63.1343074473450;
 Mon, 23 Jul 2012 13:14:33 -0700 (PDT)
Received: by 10.58.35.135 with HTTP; Mon, 23 Jul 2012 13:14:33 -0700 (PDT)
In-Reply-To: <7vhasyl0gc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201973>

On Mon, Jul 23, 2012 at 9:52 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>  -t <tool>::
>>  --tool=<tool>::
>> -     Use the diff tool specified by <tool>.  Valid values include
>> -     emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
>> -     for the list of valid <tool> settings.
>> +     Use the diff tool specified by <tool>.
>
> I do not see how it is an improvement to drop the most common ones.
> People sometimes read documentation without having an access to
> shell to run "cmd --tool-help", and a list of handful of well known
> ones would serve as a good hint to let the reader know the kind of
> commands the front-end is capable of spawning, which in turn help
> such a reader to imagine how the command is used to judge if it is
> something the reader wants to use.

I don't agree. What "most common ones" are depends on your platform
and is sort of subjective. So it should be either all or non here.
Your argument about people not having shell access is a valid one, but
still that would mean to list all tools in my opinion. And listing all
tools again thwarts our goal to reduce the number of places where new
merge / diff tools need to be added. For people adding new merge /
diff tools it is just clearer what places need to be modified if there
are no places that list an arbitrary subset of tools.

-- 
Sebastian Schuberth
