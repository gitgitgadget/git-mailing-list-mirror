From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: query: picking dependant commits from a latest tree
Date: Fri, 30 Mar 2012 11:29:10 -0500
Message-ID: <4F75DF56.10902@gmail.com>
References: <20120327095504.GM1806@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spear-devel@list.st.com
To: Shiraz Hashim <shiraz.hashim@st.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:29:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDehT-0001hP-Kr
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759684Ab2C3Q3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:29:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60339 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab2C3Q3N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:29:13 -0400
Received: by ghrr11 with SMTP id r11so455107ghr.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=W7h/DelQXkSjKfCvLPIjTZ/2UnC7ED196Xj7jR53WLI=;
        b=tyTnm5aQRAia1uucKzU+jiba4vpTu5yhpJo6BhnJrDmpUA6luaZ9UnXVYphcoF5xCb
         JhHT0lkuLedhCvfQvqab5W5jpDtDaUiFLWrvnd0h4/r9N9sJs0c1VudDJhYZSPgzP8UD
         4ZMCMnZK3ijYQ9+wvYZWWfJEG+I+tB5wn2Y7PcEhvk9KWVqvMDBWJoah72YKNMHircpG
         /d18rFnmKKU0kqdOgu1RmcqMB82nTJeyLcy4+94IORAcLj5tiuZR67xOP0/D06A/LIna
         5UAN/f9fTy+KC2SEEFBccQdMLD1SNFvPsZxQ3woeNSjvLKfPnQnpF7DLWToiXUkqPp5B
         Saig==
Received: by 10.60.2.6 with SMTP id 6mr3750542oeq.21.1333124952921;
        Fri, 30 Mar 2012 09:29:12 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id a8sm7640824oea.8.2012.03.30.09.29.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 09:29:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <20120327095504.GM1806@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194377>

On 3/27/2012 4:55 AM, Shiraz Hashim wrote:
>
> If I try to pick commits from a latest tree for a particular feature
> then what is the best way to find out all dependant commits.
>
> So for example for the commit which I want to pick there are 10 other
> commits around that file but some affect other files which themselves
> have several commits which I must apply.
>
> Is their a way to do this efficiently ?
>
You're assuming all dependencies reside in the same commits or in common 
files.  If the changes in a commit are dependent on the previous commit 
and they do not share any of the same files then what you are proposing 
is not going to catch that.

v/r,
neal
