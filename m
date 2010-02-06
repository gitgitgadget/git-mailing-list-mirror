From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Gmail and unwanted line-wrapping
Date: Sat, 6 Feb 2010 12:49:17 -0800
Message-ID: <20100206204917.GA30894@vfb-9.home>
References: <bc341e101002061229t7a1525c2w2d5a8e221124b3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Sat Feb 06 21:49:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndran-0005n3-Tv
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 21:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab0BFUtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 15:49:21 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:44340 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab0BFUtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 15:49:20 -0500
Received: by pzk17 with SMTP id 17so900381pzk.4
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 12:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=k/8P5lPNnHHAp5CCGZnsJJhuSco2wd9a7+ZCHu1Sn8s=;
        b=mNI0oZJpMlqGSwROZ6gqt2WKhdFBhV20vKPb6A/gSMpuST0gng3LP6XqMwIvjtXbWr
         7wnxsq7Z52VdrfyauWYL+GJu18XIC+5nXFZ6f4MhAIEVoawQzUiace3N428NxGxT/rJy
         RnXAOWw3kIsV53gVVFJZ2rtzFIFcf63JfRgUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pa/zreIPSkmYWJSJ2AXIXI3jjB7Nbz8o29oMdWKBjyUzFTPXLuuEJ3Yquzv0oL7de5
         5BBtaAVuBaysUqnRY7uMApiWe4A1jF2F1iL8mbYJ6KzoHiVkavv1SaH7m7Pz/QeGQ7ya
         vSZmZpjJ0fMJz28x1u3rZXrZ2s+kHPSP5L6wE=
Received: by 10.141.105.17 with SMTP id h17mr898174rvm.184.1265489359932;
        Sat, 06 Feb 2010 12:49:19 -0800 (PST)
Received: from vfb-9.home ([96.225.220.117])
        by mx.google.com with ESMTPS id 23sm4013011pzk.0.2010.02.06.12.49.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 12:49:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <bc341e101002061229t7a1525c2w2d5a8e221124b3c2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139192>

On 20:29 Sat 06 Feb     , Aaron Crane wrote:
> Documentation/SubmittingPatches says this about dealing with Gmail's
> propensity for breaking your email:
> 
> > GMail does not appear to have any way to turn off line wrapping in the web
> > interface, so this will mangle any emails that you send.  You can however
> > use any IMAP email client to connect to the google imap server, and forward
> > the emails through that.  Just make sure to disable line wrapping in that
> > email client.  Alternatively, use "git send-email" instead.
> >
> > Submitting properly formatted patches via Gmail is simple now that
> > IMAP support is available. First, edit your ~/.gitconfig to specify your
> > account settings:
> <snip>
> > Next, ensure that your Gmail settings are correct. In "Settings" the
> > "Use Unicode (UTF-8) encoding for outgoing messages" should be checked.
> >
> > Once your commits are ready to send to the mailing list, run the following
> > command to send the patch emails to your Gmail Drafts folder.
> >
> >         $ git format-patch -M --stdout origin/master | git imap-send
> >
> > Go to your Gmail account, open the Drafts folder, find the patch email, fill
> > in the To: and CC: fields and send away!
> 
> However, the advice beginning "Submitting properly formatted patches
> via Gmail is simple now" doesn't match my experience.  Following those
> guidelines seemed to work, but my patch was line-wrapped anyway.
> 
> It seems I'm not the only person who's observed this:
> http://article.gmane.org/gmane.comp.version-control.git/133020
> 
> Can anyone think of anything I might have done wrong here?  If not,
> I'm inclined to suggest dropping all of that advice.  That's not
> ideal, because it leaves Gmail users with no obvious way to submit
> well-formatted patches to the list; but it's better than suggesting
> something which apparently doesn't work.
> 
> -- 
> Aaron Crane ** http://aaroncrane.co.uk/

I don't use the web interface at all, when I want to send out patches
using GMail (we use Google Apps for Business at $day_job).  I just use
"git send-email" and send the patch(es) out straight from the command
line.  There's a nice summary online [0] of how to get this setup with
GMail.

I don't get the handy address-book of the web interface, but I don't
have to worry about line-wrapping.

[0] http://morefedora.blogspot.com/2009/02/configuring-git-send-email-to-use-gmail.html

-- 
Jacob Helwig
