From: Richard Dallaway <dallaway@gmail.com>
Subject: Re: SVN bridge for multiple SVN modules
Date: Wed, 14 Apr 2010 13:43:15 +0100
Message-ID: <v2ye3041f5c1004140543w11a16b48ye3095b266c0bc9b1@mail.gmail.com>
References: <m2ue3041f5c1004130034h51eb196dke0ebb8b3634e7302@mail.gmail.com> 
	<236FD58B-CE33-4C06-A3AC-FD7DA7593EEB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 14:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O21wV-0005Li-8H
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 14:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab0DNMnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 08:43:37 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:47289 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab0DNMnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 08:43:37 -0400
Received: by wwb34 with SMTP id 34so41481wwb.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=RUwoc5lTd2615RryQPC+ousnEHqif5lTI8pIh9VaM4w=;
        b=b7FrEcQJoS47/h68CWYfeDsFyktbJ/tMx68xNP4EJAiIQlARuGDYrCqov8+XFXsc/H
         5NR2ExYGgFmj/8UNNJGn+RO1e8PLDwNrorG3fePIEsfn6m6l+K34skSz7yf+Fa6RHBYB
         Ix8+Eb6nBjS9EJt4LkBEvj3dtE+kDJNDCexC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CS9WdNNP3vg2IfqK6La3Lpo9oXnPPWbsk8SAabbrw4E2SFdEg4bmi+LFS28g6xYThQ
         TbzCy/e9GwAegYdIH/j2MxXZ/bJM86/i/UKmIVPqNkiXW+sHl8KR/1CIpOFVYfUSgiuO
         WC8cGcxu4MvI5qZdhzDabFDVF6d7JaetQFzxs=
Received: by 10.216.159.131 with HTTP; Wed, 14 Apr 2010 05:43:15 -0700 (PDT)
In-Reply-To: <236FD58B-CE33-4C06-A3AC-FD7DA7593EEB@gmail.com>
Received: by 10.216.87.194 with SMTP id y44mr1081623wee.157.1271249015273; 
	Wed, 14 Apr 2010 05:43:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144867>

On Wed, Apr 14, 2010 at 7:08 AM, Steven Michalske <smichalske@gmail.com> wrote:
> On Apr 13, 2010, at 12:34 AM, Richard Dallaway wrote:
> Would setting up two git repositories cloning the SVN from the module_a and
> module_b directories and then making them as a git submodules is a git super
> project repository?

Thank you - I'll take a look at that.

I'm surprised that the "git svn clone
--ignore-paths=/everything_except_the_two_I-Want/" doesn't solve the
problem: I don't understand why it doesn't, and would love to
understand this better if anyone has a way to explain it.

Cheers
Richard
