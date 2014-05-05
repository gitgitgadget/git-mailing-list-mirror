From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Mon, 05 May 2014 13:15:37 -0500
Message-ID: <5367d549ae41c_25278db2ec2@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <CAEBDL5USVuFDXQk7Cb9cJ8Lm4RJNeJB0DwZBCB1cXmkroD8w3g@mail.gmail.com>
 <5367B096.80700@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>,
	John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Tue May 06 19:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi6e-0006KZ-2e
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbaEES0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 14:26:21 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:48088 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaEES0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 14:26:20 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so1570497oag.16
        for <git@vger.kernel.org>; Mon, 05 May 2014 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=w1usAcey+GZfkL5yykeur8cpwE53DE6egJGMiktFwgg=;
        b=PPNxV6ZTmWaTrWCl/FNgy2YsWrvTVAodniXvMdOcLl3FetJF9N63R5+COqRLv8beig
         oOSzgHz/ubb+13aUS/Fv7hqcGfPruwDLvrGZN0wm1/IqaJqUwu1EcE3A1Y2NsxaKhuBz
         OipOcqAOloXhWanlzvA3sYrhmn4JZWqSDm/C/ZkxKSoNFYcYWrqdvjopzQsZ2GK6Yt7D
         bUETkUs0emStx6+tbTwL5tFesZt6AdEsgXFtT4f4a0PCxS0/yIP4g/e7UqvjUEgnDIR0
         m4a+Fz8OlhIRWp/VjTaFV3Rc+S893uiJGZ3rfNapy5/mYeNhYQ/aVorghpmHGoXWhYXZ
         oSLQ==
X-Received: by 10.182.18.102 with SMTP id v6mr3960044obd.71.1399314380109;
        Mon, 05 May 2014 11:26:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ml9sm40878647oeb.2.2014.05.05.11.26.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 11:26:18 -0700 (PDT)
In-Reply-To: <5367B096.80700@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248177>

Richard Hansen wrote:
> On 2014-05-03 06:00, John Szakmeister wrote:
> > FWIW, at my company, we took another approach.  We introduced a `git
> > ffwd` command that fetches from all remotes, and fast-forwards all
> > your local branches that are tracking a remote, and everyone on the
> > team uses it all the time.  It should be said this team also likes to
> > use Git bare-metal, because they like knowing how things work
> > out-of-the-box.  But they all use the command because it's so
> > convenient.
> 
> I also wrote a script to fast-forward all local branches to their
> configured upstream refs.  I finally got around to uploading it
> somewhere public:
> 
>    https://github.com/richardhansen/git-update-branch
> 
> I use it in my 'git up' alias:
> 
>    git config --global alias.up \
>        '!git remote update -p; git update-branch -a'
> 
> If there's interest I can tweak the style to conform to
> Documentation/CodingGuidelines and stick it in contrib/ or something.

I think this would fit perfectly in the proposed `git update` command as
an option: `git update --all`.

-- 
Felipe Contreras
