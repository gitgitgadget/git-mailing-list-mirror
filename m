From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 13/17] engine.pl: provide more debug print statements
Date: Mon, 29 Jun 2015 23:27:33 +0200
Message-ID: <5591B845.8050201@gmail.com>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
 <1435190633-2208-14-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBDZMLEGXWQLBB3XQY2WAKGQESAOPM5Y@googlegroups.com Mon Jun 29 23:28:16 2015
Return-path: <msysgit+bncBDZMLEGXWQLBB3XQY2WAKGQESAOPM5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBB3XQY2WAKGQESAOPM5Y@googlegroups.com>)
	id 1Z9gbA-00036l-2o
	for gcvm-msysgit@m.gmane.org; Mon, 29 Jun 2015 23:28:16 +0200
Received: by wggz12 with SMTP id z12sf51864409wgg.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 29 Jun 2015 14:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=to:from:subject:date:lines:message-id:references:mime-version
         :content-type:user-agent:in-reply-to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=UNpf2UJ7PmgxDUmkNgvvK4J4EJ2TVcCuASG13v5NHa8=;
        b=QVToHSgzl/4UFtP9zvGDlFPSWYLmqz9wTgPQn5mH86mGvmcH/0Szm34gS5hNRf+Gtq
         C7j1eED72f6/h4rkuURdLLUY1WPmk0CwM0a7lzVtwqFu9so2ivkxKFPcTFqg8CNxDz+T
         ps5blD5kbOmDkHODY/Jfkxrm60cKx78E3MXqGcEFsAift4Smpjz9phP2MuXY9mv1ZBC4
         9PiPR3ZfAC+CLZzM92VK67LGUkdRYeYUN+umT8lMqG99Q8IwPeBDtZDPjuXDBJDgjgCA
         AV2agKVUZ1U3gJ7flUC7GR7a548JYRrLCtc+oGZxGp8hbSn6s30kIWI6RLOoVwmTaHuw
         5W3Q==
X-Received: by 10.152.36.40 with SMTP id n8mr150069laj.20.1435613295737;
        Mon, 29 Jun 2015 14:28:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.19.137 with SMTP id f9ls816821lae.5.gmail; Mon, 29 Jun
 2015 14:28:14 -0700 (PDT)
X-Received: by 10.152.27.130 with SMTP id t2mr12013959lag.2.1435613294080;
        Mon, 29 Jun 2015 14:28:14 -0700 (PDT)
Received: from plane.gmane.org (plane.gmane.org. [80.91.229.3])
        by gmr-mx.google.com with ESMTPS id wf6si1519915lbb.2.2015.06.29.14.28.14
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 14:28:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.3 as permitted sender) client-ip=80.91.229.3;
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvm-msysgit@m.gmane.org>)
	id 1Z9gb6-00034q-Dz
	for msysgit@googlegroups.com; Mon, 29 Jun 2015 23:28:12 +0200
Received: from p57a257c5.dip0.t-ipconnect.de ([87.162.87.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <msysgit@googlegroups.com>; Mon, 29 Jun 2015 23:28:12 +0200
Received: from sschuberth by p57a257c5.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <msysgit@googlegroups.com>; Mon, 29 Jun 2015 23:28:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p57a257c5.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <1435190633-2208-14-git-send-email-philipoakley@iee.org>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.3 as
 permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org;       dmarc=fail
 (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273021>

On 25.06.2015 02:03, Philip Oakley wrote:

> --- a/contrib/buildsystems/engine.pl
> +++ b/contrib/buildsystems/engine.pl
> @@ -41,6 +41,7 @@ EOM
>   # Parse command-line options
>   while (@ARGV) {
>       my $arg = shift @ARGV;
> +	#print "Arg: $arg \n";
>       if ("$arg" eq "-h" || "$arg" eq "--help" || "$arg" eq "-?") {
>   	showUsage();
>   	exit(0);
> @@ -129,6 +130,7 @@ sub parseMakeOutput
>       print "Parsing GNU Make output to figure out build structure...\n";
>       my $line = 0;
>       while (my $text = shift @makedry) {
> +		#print "Make: $text\n"; # show the makedry line

Please never commit code that's been commented out. Also see

http://dev.solita.fi/2013/07/04/whats-in-a-good-commit.html

;-)

-- 
Sebastian Schuberth

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
