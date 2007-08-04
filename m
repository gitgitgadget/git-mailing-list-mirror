From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Help a sed noob
Date: Fri, 3 Aug 2007 20:06:34 -0400
Message-ID: <fcaeb9bf0708031706o3e3f4839t39eca4b64b0aab5d@mail.gmail.com>
References: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com>
	 <7vhcngkx38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Aug 04 02:06:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH7AP-0001QV-Bg
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 02:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762282AbXHDAGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 20:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762214AbXHDAGg
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 20:06:36 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:5369 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762054AbXHDAGf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 20:06:35 -0400
Received: by an-out-0708.google.com with SMTP id d31so185918and
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 17:06:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DFYZ1+5aQIr+9VCQx5Jp10hGOG2YNrdfA+SnyF1ju8fjWQUoZr3WmDhDzUEUUW41Nx707+L+vJm5Xxt9HdQKCj4GwUCHWL4cpATAAgV83588dX95J7U1rwfrzS083xrzdJw63qVEM/a+5nCOXGwOZ7IPWkvoGR8eT2yAikFgXcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AKBfYyazJPV69OX6JLCwb8rfDdvBhF0DWwRTPRaNjo+Y0seLQtm9pzd73Tt51pexeZSky47q2wRV5gsZB+H2/ONSffsc8sUIlv95p2lpyEufuX7LAZQSm87DbyklKetXuqEOEhekgn8cQp5J2VyqLhN2s4sOSaDi9D0RGT+7uas=
Received: by 10.100.128.8 with SMTP id a8mr2014029and.1186185994351;
        Fri, 03 Aug 2007 17:06:34 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Fri, 3 Aug 2007 17:06:34 -0700 (PDT)
In-Reply-To: <7vhcngkx38.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54774>

Great! Thank you both.

On 8/3/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > There is a construct like this in git-parse-remote.sh which makes
> > busybox ash unhappy:
> >
> >                 sed -ne '/^URL: */{
> >                         s///p
> >                         q
> >                 }' "$GIT_DIR/remotes/$1"
> >
> > It complains about "no previous regexp" while gnu sed is ok. Can
> > anyone explain to me what does "s///p" do? GNU Sed info page says
> > nothing about empty regexp. If I replace it with "s/\(.*\)/\1/p" then
> > I get "URL: " along with the remote path.
>
> Traditionally empty LHS regexp means "the same as last match".
> Replace it with "s/^URL: *//p" and you would be Ok.
>
>


-- 
Duy
