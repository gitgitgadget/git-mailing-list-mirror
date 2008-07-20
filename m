From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 20 Jul 2008 22:03:24 +0200
Message-ID: <bd6139dc0807201303u406484e2x127b2391a9920425@mail.gmail.com>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
	 <20080718182010.6117@nanako3.lavabit.com>
	 <7v63r38r4r.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
	 <7vabge30dh.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness>
	 <20080720130407.GF10347@genesis.frugalware.org>
	 <7vd4l88l77.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807202102370.3305@eeepc-johanness>
	 <7vd4l85nv5.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 22:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKf8r-0001GQ-UD
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 22:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYGTUD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 16:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbYGTUD0
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 16:03:26 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:2641 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYGTUDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 16:03:25 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1242183wfd.4
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LTUPyEzWmt/pI8B4ijEnkXVUWvwx/IKejDXL+JG34zY=;
        b=NJUzPHDv5zBv7LXlJvjgBj2fTAmrFvaa9a+z5D1kIYPwCIy7HgJzjo2DwZ2vC7BqKt
         2XoCLsEzvdamm7r5/nzqLu+ko9NYvRa/0NJmjxOL7u0W/ag6K3OV15662PFPiLZKOFVj
         4vmyLITkjCXSJsDAeI+9KuUoekGF6weuHMU14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=uY3IM0lLvXs0jqKK/OuExAPNk/9Q9MqO3U68XlxutTKFkmu1so5BFeUPmQJxV3qoOf
         ycDnfLZDReUfiJnGr7C5noECVdD9mlf6fJBKi4lWtUbES4lsMsFHim1t9Vk60QaVTYMB
         ZMbmKEyF+eJrzndDqPEeUoIIOu4rIhPqBolHI=
Received: by 10.142.88.4 with SMTP id l4mr1002803wfb.238.1216584204672;
        Sun, 20 Jul 2008 13:03:24 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sun, 20 Jul 2008 13:03:24 -0700 (PDT)
In-Reply-To: <7vd4l85nv5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89222>

On Sun, Jul 20, 2008 at 9:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> You mean something like
>>
>>       $ git merge -s subtree -X --path -X git-gui/ git-gui/master
>>
>> Wow. :-)
>
> I would envision it to be more like:
>
>        $ git merge -s subtree -Xpath=git-gui git-gui/master

Whatever happened to quotes?

        $ git merge -s subtree -Xpath="git-gui git-gui/master"

-- 
Cheers,

Sverre Rabbelier
