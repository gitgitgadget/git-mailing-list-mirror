From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH] A simple script to parse the results from the testcases
Date: Sun, 8 Jun 2008 20:06:31 +0200
Message-ID: <237967ef0806081106i77bec10u3d42170eeaf474e9@mail.gmail.com>
References: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
	 <1212884291-13847-1-git-send-email-vmiklos@frugalware.org>
	 <bd6139dc0806071734h16aa4218md051fbbe9f025f43@mail.gmail.com>
	 <20080608004928.GG29404@genesis.frugalware.org>
	 <bd6139dc0806071756k331c9b29obc5f1cb525ef47d8@mail.gmail.com>
	 <20080608022656.GH29404@genesis.frugalware.org>
	 <bd6139dc0806080443g64403fa4o855809b70e367f0@mail.gmail.com>
	 <alpine.DEB.1.00.0806081826570.1783@racer>
	 <bd6139dc0806081030i32266a2n633f7679f4a02bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org,
	dsymonds@gmail.com
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 20:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5PIf-00058C-L1
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 20:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbYFHSGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 14:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbYFHSGf
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 14:06:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:16984 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbYFHSGe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 14:06:34 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2219836rvb.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HozqeI4nB1+nu4JLlmLJmWoASQ2VdYOsjFvJlNcpbbo=;
        b=gAyM3w0m4cdBDJZmmvTqjVFh4b70jy7vOKf8PW/HV0AOmX5Kf+v1+NfTYGHDtoJakB
         tLLVvRnpEGcW1LmzTyGNkscwq53K9KIonAsSynlpNYrrkc+jFPirPDtW7HUHtYFq0Ny4
         5pfWPRwhZbyzI9AHPKF/BkXWCAt5tmoYbUpYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=g3PWY1xdp6ec/Fu28HwK2Y90ZN6yUWgEDd7gnUh/lfZ1m4kVm9SmHE6U06s/tIkXPB
         7KmJa39s5Zxq0ZOelcJ4gAz3CStE2cj8RVCcnOk+pcGYcB4PMjV0GxqxTyF9j7EMns4J
         ekbj7cCJ+2bK7siyo7iTREkCfkpO1i5aFuCzA=
Received: by 10.141.36.10 with SMTP id o10mr1507685rvj.176.1212948391660;
        Sun, 08 Jun 2008 11:06:31 -0700 (PDT)
Received: by 10.141.153.6 with HTTP; Sun, 8 Jun 2008 11:06:31 -0700 (PDT)
In-Reply-To: <bd6139dc0806081030i32266a2n633f7679f4a02bb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84303>

2008/6/8 Sverre Rabbelier <srabbelier@gmail.com>:
> On Sun, Jun 8, 2008 at 7:27 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Sun, 8 Jun 2008, Sverre Rabbelier wrote:
>>
>>> I used the 'show original message' feature, so that I could edit it
>>> before applying.
>>
>> FWIW that's what "commit --amend" and "rebase --interactive" are for.
>
> Hmmm, yeah, but can you change the filename easily with commit
> --ammend / rebase --interactive?

git mv oldname newname
git commit --amend ;: not --ammend

-- 
Mikael Magnusson
