From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Push to all repositories
Date: Thu, 9 Dec 2010 19:47:36 +0700
Message-ID: <AANLkTim_4sqyrE=MFOVxskANNL9-z29=iH3grNae7Yt3@mail.gmail.com>
References: <1291829983410-5816069.post@n2.nabble.com> <20101208180049.GC5687@burratino>
 <1291849156593-5817177.post@n2.nabble.com> <1291898174244-5818757.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Kevin Sheedy <kevinsheedy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 13:48:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQfuy-0002hh-Ee
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 13:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756184Ab0LIMsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 07:48:08 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62165 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944Ab0LIMsH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 07:48:07 -0500
Received: by wyb28 with SMTP id 28so2235918wyb.19
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 04:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Uky+zXMQY8DT7GczcnZ1IBWpsa8+EWTS1d/QEVa2G2Y=;
        b=K+Ylq16zZ77ES6e5FuUNhh/YO5rLoTry2Joawl11Y06tChnCR+CWpM5dbzEfUht6Qu
         NjJmJVmUPpnfeVd5QnZVuEhm2SKah4etX1mAgBRrJLb4e5AK2PUCgiXRKZnylKvfU35i
         zuY4oWACEcza6XHa5IW9XhfdgFXfyZBr2xWwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KXTi0JB7odA8gFcJ6aSlQgCylNFsE8TcwaA7UUUQnCj+rVV5cIkyI74YhX5iVaDwtB
         To7NMv4HV/2KTMRkY7zeh7dpJAbV6d/PON4hUp3oOhFNYMVaCxCXb7iwptOzZB7F5slP
         XF1sB9UXzJnexsnPefbneTmwWo2psP9lwU66U=
Received: by 10.216.24.134 with SMTP id x6mr521887wex.34.1291898886488; Thu,
 09 Dec 2010 04:48:06 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Thu, 9 Dec 2010 04:47:36 -0800 (PST)
In-Reply-To: <1291898174244-5818757.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163279>

On Thu, Dec 9, 2010 at 7:36 PM, Kevin Sheedy <kevinsheedy@gmail.com> wrote:
>
> In summary, I think it would be cool if there was a programmatic way of
> saying:
> "Hey everybody, I've changed some code on branch x and I think you should
> have it"

See "update" hook in githooks man page. Add "pushall" alias for "for
repo in..." from Jonathan's mail.
-- 
Duy
